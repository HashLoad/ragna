unit Ragna.Types;

interface

type
  TOperatorType = (otWhere, otOr, otLike, otEquals, otOrder, otAnd);

  TOperatorTypeHelper = record helper for TOperatorType
  public
    function ToString: string;
  end;

implementation

function TOperatorTypeHelper.ToString: string;
begin
  case Self of
    otWhere:
      Result := 'WHERE';
    otOr:
      Result := 'OR';
    otLike:
      Result := 'LIKE';
    otEquals:
      Result := '=';
    otOrder:
      Result := 'ORDER BY';
    otAnd:
      Result := 'AND';
  end;
end;

end.
