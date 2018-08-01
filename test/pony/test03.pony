primitive TupleElementTest
  fun errNonIndex() =>
    let a: I32 = 1
    let t = (a, a, a)
    t._1p

  fun errZero() =>
    let a: I32 = 1
    let t = (a, a, a)
    t._0
    t._00

  fun matchSingleDigit() =>
    let a: I32 = 1
    let t = (a, a, a)
    t._1
    t._2
    t._3

  fun matchMultiDigit() =>
    let a: I32 = 1
    let t = (a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a,
             a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a,
             a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a,
             a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a)
    t._10
    t._37
    t._100

  fun matchZeroPadded() =>
    let a: I32 = 1
    let t = (a, a, a, a, a, a, a, a, a, a)
    t._01
    t._10
    t._001
    t._010

  fun noMatchAfterNonPeriod() =>
    (1, 2, _3)
    [1; 2; _3]

class NoMatchPrivateField
  var _x: I32 = 0
  fun ref swap(other: NoMatchPrivateField) =>
    _x = (other._x = _x)
