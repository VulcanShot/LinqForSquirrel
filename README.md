# LinqForSquirrel

This is the second weird project of mine attempting to code in Squirrel an existing successful library. This time, I kinda made [LINQ](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/linq/) in an engine-independent Squirrel.

## Instructions

1. Download ***Linq.nut*** from the latest release and place it under `csgo/scripts/vscripts`.

2. Reference it in a script. Referencing it multiple time will not impact performance.
   Example: `IncludeScript("Linq")`

3. You can start ~~thinking about how stupid this idea is~~ using Linq (sorta) in your amazing Squirrel projects!

## Getting Started

This is very simple. Instantiate a `Linq` object providing an array like so:

```squirrel
local myArray = [1, 2, 3];
local linqBadBoy = Linq(myArray);
```
Now, you can access any of the amazing functions provided by the library. Note that you can chain those who return a `Linq` object.

## Functions

```cs
Linq Where(function predicate);
object First(function? predicate = null);
object Last(function? predicate = null);
object Single(function predicate);
bool Any(function? predicate = null);
bool All(function predicate);
bool Contains(object value);
Linq OrderBy(string propertyName);
Linq OrderByDescending(string propertyName);
Linq Skip(int count);
Linq Take(int count);
object Max(string? propertyName = null);
object Min(string? propertyName = null);
object Sum(string? propertyName = null);
object Average(string? propertyName = null);
int Count(function? predicate = null);
Table ToTable(string keyPropertyName, string? valuePropertyName = null);
Array ToArray();
```

Keep in mind that `predicate` parameter functions must follow this signature:

```cs
bool predicate(Object element);
```
