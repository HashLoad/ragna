unit Ragna.State;

interface

uses
  System.Generics.Collections;

type

  TRagnaState = class
  private
    FSecret: string;
    FStates: TThreadList<TPair<Pointer, string>>;
    class var FInstance: TRagnaState;
  public
    property States: TThreadList < TPair < Pointer, string >> read FStates
      write FStates;
    procedure SetState(APointer: Pointer; ASQL: string);
    function GetState(APointer: Pointer): string;
    function RemoveState(APointer: Pointer): string;
    class function GetInstance: TRagnaState;
    class procedure Release;
    constructor Create;
    destructor Destroy;
  end;

implementation

{ TRagnaState }

constructor TRagnaState.Create;
begin
  FStates := TThreadList < TPair < Pointer, string >>.Create;
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

function TRagnaState.GetState(APointer: Pointer): string;
var
  LState: TPair<Pointer, string>;
  LStates: TList<TPair<Pointer, string>>;
begin
  LStates := FStates.LockList;
  try
    for LState in LStates do
    begin
      if LState.Key = APointer then
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

function TRagnaState.RemoveState(APointer: Pointer): string;
var
  LState: TPair<Pointer, string>;
  LStates: TList<TPair<Pointer, string>>;
begin
  LStates := FStates.LockList;
  try
    for LState in LStates do
    begin
      if LState.Key = APointer then
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

procedure TRagnaState.SetState(APointer: Pointer; ASQL: string);
var
  LState: TPair<Pointer, string>;
begin
//  TMonitor.Enter(FList);
  try
//    FList.Add();
  finally
//    TMonitor.Exit(FList);
  end;

  LState := TPair<Pointer, string>.Create(APointer, ASQL);
  FStates.Add(LState);
end;

initialization

TRagnaState.GetInstance;

finalization

TRagnaState.Release;

end.
