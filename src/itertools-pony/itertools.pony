"""
Provide a set of classes for doing useful things with
iterators. Inspired by Python's itertools library.
"""

class Chain[A] is Iterator[A]
"""
Chain two iterators together to create an iterator that iterates
through the first iterator, then the second iterator.
"""
  let _i1: Iterator[A]
  let _i2: Iterator[A]

  new create(i1: Iterator[A], i2: Iterator[A]) =>
    _i1 = i1
    _i2 = i2

  fun ref has_next(): Bool =>
    _i2.has_next()

  fun ref next(): A ? =>
    if _i1.has_next() then
      _i1.next()
    else
      _i2.next()
    end

class Zip2[A, B] is Iterator[(A, B)]
"""
Zip two iterators together so that each call to next() results in the
a tuple with the next value of the first iterator and the next value
of the second iterator. The number of items returned it the minimum of
the number of items returned by the two iterators.
"""
  let _i1: Iterator[A] ref
  let _i2: Iterator[B] ref

  new create(i1: Iterator[A] ref, i2: Iterator[B] ref) =>
    _i1 = consume i1
    _i2 = consume i2

  fun ref has_next(): Bool =>
    _i1.has_next() and _i2.has_next()

  fun ref next(): (A, B) ? =>
    (_i1.next(), _i2.next())

class Zip3[A, B, C] is Iterator[(A, B, C)]
"""
Zip three iterators together so that each call to next() results in
the a tuple with the next value of the first iterator, the next value
of the second iterator, and the value of the third iterator. The
number of items returned it the minimum of the number of items
returned by the three iterators.
"""
  let _i1: Iterator[A] ref
  let _i2: Iterator[B] ref
  let _i3: Iterator[C] ref

  new create(i1: Iterator[A] ref, i2: Iterator[B] ref, i3: Iterator[C]) =>
    _i1 = i1
    _i2 = i2
    _i3 = i3

  fun ref has_next(): Bool =>
    _i1.has_next() and _i2.has_next() and _i3.has_next()

  fun ref next(): (A, B, C) ? =>
    (_i1.next(), _i2.next(), _i3.next())

class Zip4[A, B, C, D] is Iterator[(A, B, C, D)]
"""
Zip four iterators together so that each call to next() results in the
a tuple with the next value of each of the iterators. The number of
items returned it the minimum of the number of items returned by the
iterators.
"""
  let _i1: Iterator[A] ref
  let _i2: Iterator[B] ref
  let _i3: Iterator[C] ref
  let _i4: Iterator[D] ref

  new create(i1: Iterator[A] ref, i2: Iterator[B] ref, i3: Iterator[C], i4: Iterator[D]) =>
    _i1 = i1
    _i2 = i2
    _i3 = i3
    _i4 = i4

  fun ref has_next(): Bool =>
    _i1.has_next() and _i2.has_next() and _i3.has_next() and _i4.has_next()

  fun ref next(): (A, B, C, D) ? =>
    (_i1.next(), _i2.next(), _i3.next(), _i4.next())

class Zip5[A, B, C, D, E] is Iterator[(A, B, C, D, E)]
"""
Zip five iterators together so that each call to next() results in the
a tuple with the next value of each of the iterators. The number of
items returned it the minimum of the number of items returned by the
iterators.
"""
  let _i1: Iterator[A] ref
  let _i2: Iterator[B] ref
  let _i3: Iterator[C] ref
  let _i4: Iterator[D] ref
  let _i5: Iterator[E] ref

  new create(i1: Iterator[A] ref, i2: Iterator[B] ref, i3: Iterator[C], i4: Iterator[D], i5: Iterator[E]) =>
    _i1 = i1
    _i2 = i2
    _i3 = i3
    _i4 = i4
    _i5 = i5

  fun ref has_next(): Bool =>
    _i1.has_next() and _i2.has_next() and _i3.has_next() and _i4.has_next() and _i5.has_next()

  fun ref next(): (A, B, C, D, E) ? =>
    (_i1.next(), _i2.next(), _i3.next(), _i4.next(), _i5.next())

class Repeat[A] is Iterator[A]
  let _v: A

  new create(v: A) =>
    _v = consume v

  fun ref has_next(): Bool =>
    true

  fun ref next(): A =>
    _v

class Limit[A] is Iterator[A]
"""
Create an iterator from the original iterator that only returns a
specified number of items.
"""
  var _countdown: USize
  let _i: Iterator[A]

  new create(i: Iterator[A], l: USize) =>
    _countdown = l
    _i = i

  fun ref has_next(): Bool =>
    (_countdown > 0) and _i.has_next()

  fun ref next(): A ? =>
    _countdown = _countdown - 1
    _i.next()

class Cycle[A] is Iterator[A!]
"""
Create an iterator that repeatedly cycles through the values from the
original iterator.

WARNING: The values returned by the original iterator are cached, so
the input iterator should be finite.
"""
  let _store: Array[A!]
  var _iter: Iterator[A!]
  var _first_time_through: Bool = false
  new create(iter: Iterator[A!]) =>
    _store = Array[A!]
    for v in iter do
      _store.push(v)
    end
    _iter = _store.values()
  fun ref has_next(): Bool =>
    true
  fun ref next(): A! ? =>
    if _iter.has_next() then
      if _first_time_through then
        _store.push(_iter.next())
        _store(_store.size() - 1)
      else
        _iter.next()
      end
    else
      if _first_time_through then
        _first_time_through = false
      end
      _iter = _store.values()
      _iter.next()
    end
