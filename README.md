# ragna
<b>Ragna</b> Ragna is a query builder for projects written in Delphi, compatible with FireDAC and UniDAC components.
<br>We created a channel on Telegram for questions and support:<br><br>
<a href="https://t.me/hashload">
  <img src="https://img.shields.io/badge/telegram-join%20channel-7289DA?style=flat-square">
</a>

## ⚙️ Installation
Installation is done using the [`boss install`](https://github.com/HashLoad/boss) command:
``` sh
boss install ragna
```
If you choose to install manually, simply add the following folders to your project, in *Project > Options > Resource Compiler > Directories and Conditionals > Include file search path*
```
../ragna/src/core
../ragna/src/helpers
../ragna/src/interfaces
../ragna/src/state
../ragna/src/types
```

## ⚡️ Quickstart
You need to use Ragna
```pascal
uses Ragna;
```

* Open query
```delphi
begin
  Country.OpenUp;
end;
```

* Open empty query
```delphi
begin
  Country.OpenEmpty;
end;
```

* Where
```delphi
begin
  Country
    .Where(CountryName).Equals('Brazil')
    .OpenUp;
end;
```

* Or
```delphi
begin
  Country
    .Where(CountryName).Equals('Brazil')
    .&Or(CountryName).Equals('Canada')
    .OpenUp;
end;
```

* And
```delphi
begin
  Country
    .Where(CountryName).Equals('Brazil')
    .&And(CountryCapital).Equals('Brasilia')
    .OpenUp;
end;
```

* Like
```delphi
begin
  Country
    .Where(CountryName).Like('B')
    .OpenUp;
end;
```

* Order
```delphi
begin
  Country
    .Order(CountryName)
    .OpenUp;
end;
```

* To JSON object
```delphi
var
  LJson: TJSONObject;
begin
  LJson := Country.OpenUp.ToJSONObject;
end;
```

* To JSON array
```delphi
var
  LJson: TJSONArray;
begin
  LJson := Country.OpenUp.ToJSONArray;
end;
```

## ⚠️ License
`Ragna` is free and open-source middleware licensed under the [MIT License](https://github.com/HashLoad/ragna/blob/master/LICENSE). 
