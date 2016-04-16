# itertools-pony

A library for doing useful things with iterators in Pony (inspired by the Python itertools library).

## Examples

### Chain

Chain together two iterators.

```pony
    // prints the numbers 1 through 14

    let i1 = [as I32: 1, 2, 3, 4]
    let i2 = [as I32: 5, 6, 7, 8, 9]
    let i3 = [as I32: 10, 11, 12, 13, 14]

    for x in Chain[I32]([i1.values(), i2.values(), i3.values()].values())
      env.out.print(x.string())
    end
```

### Take

Return only the specified number of items from the given iterator.

```pony
    // prints the numbers 10 through 12

    let i3 = [as I32: 10, 11, 12, 13, 14]
    
    for x in Take[I32](i3.values(), 3) do
      env.out.print(x.string())
    end
```

### Zip

Create a new iterator that returns a tuple of the next values in the
given iterators. There are classes for zipping two to five iterators
together (Zip2, Zip3, Zip4, Zip5).

```pony
    // print the following:
    // 1 a
    // 2 b
    // 3 c

    var i4: Array[I32] ref = [as I32: 1, 2, 3]
    var i5: Array[String] ref = ["a", "b", "q", "f"]

    for (x, y) in Zip2[I32, String](i4.values(), i5.values()) do
      env.out.print("".add(x.string()).add(" ").add(y))
    end
```

### Repeat

Create an iterator that repeatedly returns the given value.

```pony
    // print the number 7 forever
    
    for x in Repeat[U32](7) do
      env.out.print(x.string())
    end
```

### Cycle

Create an iterator that infinitely loops over the items of the given
iterator.

```pony
    // print the number 1 through 4 forever

    let i1 = [as I32: 1, 2, 3, 4]
    
    for x in Cycle[I32](i1.values()) do
      env.out.print(x.string())
    end
```

### MapFn

Create an iterator that applies a function to an input iterator.

```pony
    // double the input values

    let i1 = [as I32: 1, 2, 3, 4]
    
    for x in MapFn[I32, I32](i1.values(),
                             lambda(x: I32): I32 =>
                             x * 2 end) do
      env.out.print(x.string())
    end
```

### Filter

Create an iterator that applies a predicate function to an given
iterator and only returns items that match the predicate.

```pony
    // only print even numbers

    let i1 = [as I32: 1, 2, 3, 4]
    
    for x in Filter[I32](i1.values(),
                         lambda(x: I32): Bool =>
                         x % 2 == 0 end) do
      env.out.print(x.string())
    end
```

## TODO

* Add other classes for dealing with iterators
