# Basic Types

## Basic types

`new(T)` creates an _unnamed_ variable of type T, initializes it to 0, and returns the _pointer to T_

### Constants

Constants are only basic types \(boolean, string, number\) or named types of the basic types. Constants can appear in types, such as the length of an array type

```go
const IPv4Len4 = 4

var p [IPv4Len]byte
```

## Composite Types

### Arrays

Arrays are fixed length, length must be declared or an ellipsis can be used with an initialization list

```go
a := [...]int{1,2,3}
b := [3]int{1,2,3}
a = [4]int{1,2,, 4} // compile error
```

Literal syntax can also used named incidices, for example:

```go
type Currency int

const (
    USD Currency = iota
    EUR
    GBP
)

symbol: [...]string{USD: "$", EUR: "€", GBP: "£"}

fmt.Println(symbol[GBP]) // "£"
```

Comparison: Arrays can be compared if they have comparable element types and are the same length.

Arrays are passed-by-value to functions. The function receives a new copy. Importantly, pass-by-value also puts it on the stack.

### Slices

The _capacity_ \(with built-in function `cap`\) of a slice is the maximum a slice can be extended.

Slices can't be compared, except for two slices of bytes using `bytes.Equal`

Slices aren't passed by value to functions, but instead are pointers to the elements of an underlying array.

`make` creates a slice of a type, length, and capacity \(capacity may be omitted, then capacity == length\)

The built-in function `copy` copies elements from one slice to another.

The shortest way to make a slice from an array is `myArray[:]`. Useful when you have an array but a function takes a slice.

