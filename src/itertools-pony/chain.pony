class Chain[A] is Iterator[A!]
  """
  Take an iterator of iterators and work through them, returning the
  items of the first one, then the second one, and so on.

  ## Example program

  Print the numbers 1 through 14

  ```pony
  use "itertools"

  actor Main
    new create(env: Env) =>
      let i1 = [as I32: 1, 2, 3, 4]
      let i2 = [as I32: 5, 6, 7, 8, 9]
      let i3 = [as I32: 10, 11, 12, 13, 14]
    
      for x in Chain[I32]([i1.values(), i2.values(), i3.values()].values()) do
        env.out.print(x.string())
      end
  ```
  """
  let _outer_iterator: Iterator[Iterator[A!]]
  var _inner_iterator: Iterator[A!]

  new create(outer_iterator: Iterator[Iterator[A!]]) =>
    _outer_iterator = outer_iterator
    _inner_iterator = Array[A!]().values()

    try
      _inner_iterator = outer_iterator.next()
      while _outer_iterator.has_next() and (not _inner_iterator.has_next()) do
        _inner_iterator = _outer_iterator.next()
      end
    end

  fun ref has_next(): Bool =>
    _outer_iterator.has_next() or _inner_iterator.has_next()

  fun ref next(): A! ? =>
    let out: A! = _inner_iterator.next()
    while (not _inner_iterator.has_next()) and _outer_iterator.has_next() do
      _inner_iterator = _outer_iterator.next()
    end
    out