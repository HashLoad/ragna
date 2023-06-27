unit Ragna.Types;

{$IF DEFINED(FPC)}
  {$MODE DELPHI}{$H+}
{$ENDIF}

interface

type
{$SCOPEDENUMS ON}
  TOperatorType = (WHERE, &OR, LIKE, EQUALS, ORDER, &AND);
{$SCOPEDENUMS OFF}

  TOperatorTypeHelper = record helper for TOperatorType
  public
    function ToString: string;
  end;

implementation

function TOperatorTypeHelper.ToString: string;
begin
  case Self of
    TOperatorType.WHERE:
      Result := 'WHERE';
    TOperatorType.OR:
      Result := 'OR';
    TOperatorType.LIKE:
      Result := 'LIKE';
    TOperatorType.EQUALS:
      Result := '=';
    TOperatorType.ORDER:
      Result := 'ORDER BY';
    TOperatorType.AND:
      Result := 'AND';
  end;
end;

end.
