# 제목 1

## 제목 2

### 제목 3

Hi! :smiley: :turtle:

### 테이블

| a | b  |  c |  d  |
| - | :- | -: | :-: |
| ㄱ| ㄴ | ㄷ | ㄹ  |


``` python
import random

class MyCalss(YourClass):
    """ docstring """
    def __init__(self):
        self.name = 'hello' #comment
        self.cnt = int()

def test(a, b):
    if True:
      a += [3]
    return a + b
```

---

``` c
#include <stdio>

int main(int args char** argv) {
// comment
 char a = 'c';
 int k = 3;
 char s[4] = 'test';
 for (int i=0; i<3; i++){
   a += 1;
 }
 return a;
}
```

``` js
import React, { useState } from 'react';

export default function MyComponent({ clickHandler }) {
  const [key,setKey] = useState('');
  let myval = 0;
  const myObj = new myClass();
  const test = {a: 1, b:'testt'};
  test.a = 3;

  return (
    <div>
    {true && [1,2,3].map((a, idx) => {
      console.log('test');
      return <div id={`test ${test}`} prop='test' onClick={clickHandler} >{a} hey</div>
    })}
    </div>
  );
}

```

***굵게***
*기울이기*

inline `Code` 나타내기

> 안쪽으로

* Lists
- list1
> * list2

- [ ] todo

- [x] done

A paragraph with *emphasis* and **strong importance**.


> A block quote with ~strikethrough~ and a URL: https://reactjs.org.

[test](https://google.com)

The lift coefficient ($C_L$) is a dimensionless coefficient.


This Markdown contains <a href="https://en.wikipedia.org/wiki/HTML">HTML</a>, and will require the <code>html-parser</code> AST plugin to be loaded, in addition to setting the <code class="prop">allowDangerousHtml</code> property to false.