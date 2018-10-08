unit Ragna.State;

interface

uses
  System.Generics.Collections, FireDac.Comp.Client;

type

  TPairOfQueryAndSql = TPair<TFDQuery,string>;

  TRagnaState = class
  private
    FSecret: string;
    FStates: TThreadList<TPairOfQueryAndSql>;
    class var FInstance: TRagnaState;
  public
    property States: TThreadList<TPairOfQueryAndSql> read FStates write FStates;
    procedure SetState(AQuery: TFDQuery; ASQL: string);
    function GetState(AQuery: TFDQuery): string;
    function RemoveState(AQuery: TFDQuery): string;
    class function GetInstance: TRagnaState;
    class procedure Release;
    constructor Create;
    destructor Destroy;
  end;

implementation

{ TRagnaState }

constructor TRagnaState.Create;
begin
  FStates := TThreadList<TPairOfQueryAndSql>.Create;
end;

destructor TRagnaState.Destroy;
begin
  FStates.Free;
end;

class function TRagnaState.GetInstance: TRagnaState;
begin
  if not assigned(FInstance) then
    FInstance := TRagnaState.Create;
  Result := FInstance;
end;

function TRagnaState.GetState(AQuery: TFDQuery): string;
var
  LState: TPairOfQueryAndSql;
  LStates: TList<TPairOfQueryAndSql>;
begin
  LStates := FStates.LockList;
  try
    for LState in LStates do
    begin
      if LState.Key = AQuery then
      begin
        Result := LState.Value;
        Break;
      end;
    end;
  finally
    FStates.UnlockList;
  end;
end;

class procedure TRagnaState.Release;
begin
  FInstance.Free;
end;

function TRagnaState.RemoveState(AQuery: TFDQuery): string;
var
  LState: TPairOfQueryAndSql;
  LStates: TList<TPairOfQueryAndSql>;
begin
  LStates := FStates.LockList;
  try
    for LState in LStates do
    begin
      if LState.Key = AQuery then
      begin
        Result := LState.Value;
        Break;
      end;
    end;
  finally
    FStates.UnlockList;
  end;

  LStates.Remove(LState);
end;

procedure TRagnaState.SetState(AQuery: TFDQuery; ASQL: string);
var
  LState: TPairOfQueryAndSql;
begin
  LState := TPairOfQueryAndSql.Create(AQuery, ASQL);
  FStates.Add(LState);
end;

initialization

TRagnaState.GetInstance;

finalization

TRagnaState.Release;

end.
