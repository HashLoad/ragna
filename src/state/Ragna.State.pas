unit Ragna.State;

interface

uses System.Generics.Collections, FireDac.Comp.Client, System.Rtti;

type
  TListQueryAndSql = TDictionary<TFDQuery, string>;

  TRagnaState = class
  private
    FStates: TListQueryAndSql;
    FVmi: TVirtualMethodInterceptor;
    class var FInstance: TRagnaState;
    procedure OnBeforVMI(Instance: TObject; Method: TRttiMethod; const Args: TArray<TValue>; out DoInvoke: Boolean;
      out Result: TValue);
  public
    destructor Destroy; override;
    property States: TListQueryAndSql read FStates write FStates;
    procedure SetState(const AQuery: TFDQuery; const ASQL: string);
    function GetState(const AQuery: TFDQuery; out ASQL: string): Boolean;
    class function GetInstance: TRagnaState;
    class procedure Release;
    constructor Create;
  end;

implementation

constructor TRagnaState.Create;
begin
  FVmi := TVirtualMethodInterceptor.Create(TFDQuery);
  FVmi.OnBefore := OnBeforVMI;
  FStates := TListQueryAndSql.Create;
end;

destructor TRagnaState.Destroy;
begin
  FStates.Free;
  FVmi.Free;
end;

class function TRagnaState.GetInstance: TRagnaState;
begin
  if not assigned(FInstance) then
    FInstance := TRagnaState.Create;
  Result := FInstance;
end;

function TRagnaState.GetState(const AQuery: TFDQuery; out ASQL: string): Boolean;
begin
  TMonitor.Enter(FStates);
  try
    Result := FStates.TryGetValue(AQuery, ASQL);
  finally
    TMonitor.Exit(FStates);
  end;
end;

procedure TRagnaState.OnBeforVMI(Instance: TObject; Method: TRttiMethod; const Args: TArray<TValue>; out DoInvoke: Boolean;
  out Result: TValue);
begin
  if Method.Name <> 'BeforeDestruction' then
    Exit;
  TMonitor.Enter(FStates);
  try
    FStates.Remove(Instance as TFDQuery);
  finally
    TMonitor.Exit(FStates);
  end;
end;

class procedure TRagnaState.Release;
begin
  FInstance.Free;
end;

procedure TRagnaState.SetState(const AQuery: TFDQuery; const ASQL: string);
begin
  TMonitor.Enter(FStates);
  try
    if FVmi.ProxyClass <> AQuery.ClassType then
      FVmi.Proxify(AQuery);
    FStates.AddOrSetValue(AQuery, ASQL);
  finally
    TMonitor.Exit(FStates);
  end;
end;

initialization
  TRagnaState.GetInstance;

finalization
  TRagnaState.Release;

end.
