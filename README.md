# *Latte* Compiler - "Compiler Construction" Course @ MIMUW

### Author: Michał Preibisch   
###  michal.preibisch@gmail.com  

## Prelude

Compiler is written in **Haskell**. I didn't use any sophisticated techniques and functional-programming hacky things that Haskell provides and limited myself to just State and Error monad.

It translates Latte source code into assembly (**x86** - 32 bit) in **AT&T** syntax, links created *.s file with runtime library and compiles it to executable file via GCC.

I require:
-  Cabal 1.22.* for building the project
- libc6-dev:i386 / gcc-6-multilib  packages for 32-bit compile

Project structure:
```
----/src 		                - source files
--------/BackEnd                - module responsible for code translation
--------/FrontEnd               - module for static analysis (checker for typing and declarations)
------------/Grammar            - Parser module provided by **bnfc** tool
--------/main.hs                - main module
----/tests                      - tests written in Latte
/testCompile.sh                 - script for compilation of tests
/testExecution.sh               - script for execution of tests (and output-check)
```

# Installation
Assuming that both Cabal, GCC, GNU Make and all mentioned packages are visible environment,
simply type:

```
make
```
In project's main directory.
**latc_x86** file will be created in project's main directory. To run a compiler, you need to provide a file with Latte source code. For example:
```
./latc_x86 /foo/bar/fibo_heaps.lat
```
As a result,  *fibo_heaps* executable file will be created in */foo/bar* directory.

# Latte
**Latte** is strongly and statically typed, imperative toy-language that supports *object-oriented programming (OOP)*. It supports all common programming languages' construction, such as loops, if-else statements, functions (with recursion), primitive data types - int, boolean, string and also arrays. Additionally, Latte provides measures for OOP - classes with inheritance and polymorhism.

It's syntax is similar to Java. Latte can be easily translated to it. Example code snippet of Latte:
```Java
class Node {
  Shape elem;
  Node next;
  int[] unused_array; // Just for example

  void setElem(Shape c) { elem = c; }

  void setNext(Node n) { next = n; }

  Shape getElem() { return elem; }

  Node getNext() { return next; }
}

class Stack {
  Node head;

  void push(Shape c) {
    Node newHead = new Node;
    newHead.setElem(c);
    newHead.setNext(head);
    head = newHead;
  }

  boolean isEmpty() {
    return head==(Node)null;
  }

  Shape top() {
    return head.getElem();
  }

  void pop() {
    head = head.getNext();
  }
}

class Shape {
  void tell () {
    printString("I'm a shape");
  }

  void tellAgain() {
     printString("I'm just a shape");
  }
}

class Rectangle extends Shape {
  void tellAgain() {
    printString("I'm really a rectangle");
  }
}

class Circle extends Shape {
  void tellAgain() {
    printString("I'm really a circle");
  }
}

class Square extends Rectangle {
  void tellAgain() {
    printString("I'm really a square");
  }
}

int main() {
  Stack stk = new Stack;
  Shape s = new Shape;
  stk.push(s);
  s = new Rectangle;
  stk.push(s);
  s = new Square;
  stk.push(s);
  s = new Circle;
  stk.push(s);
  while (!stk.isEmpty()) {
    s = stk.top();
    s.tell();
    s.tellAgain();
    stk.pop();
  }
  return 0;
}
```
## Details:
I treat  post-incrementation and post-decrementation as statements, so
```Java
int i = 0;
int x = i++;
```
instructions would result with an error, since "i++" is not an expression. Standalone
```Java
i++;
i--;
```
instructions are permitted.

I require nulls to be explicitly cast to an object type. There is no general NULL as in C. For example:
```Java
Node node = null;
```
would cause an error. Correct null-assignent is:
```Java
Node node = (Node)null;
```
Unreachable code is detected in static phase and is treated as an error. For example:
```Java
void fun() {
	if (true)
		return;

	printString("This will not compile! This statement is unreachable!");
}
```

Function parameters are passed by value.
Attributes in classes must be declared separately. For example:
```Java
class TreeNode {
	TreeNode left, right;
	int data;
}
```
It not permitted. Correct code would be:
```Java
class TreeNode {
	TreeNode left;
	TreeNode right;
	int data;
}
```


I do not make a good use of asm registers. In fact - I have implemented a simple stack machine and use registers only to temporarily store data to perform operations.

Tests in /tests directory are not created by me. They are provided by course lecturers and other students.

## Resources used

https://www.haskell.org/hoogle/

https://en.wikibooks.org/wiki/X86_Disassembly

https://stackoverflow.com/
