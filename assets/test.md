[XD](https://xd.adobe.com/view/f1412248-d627-4c4e-a24c-0e05a08434df-a412/)

![image](https://user-images.githubusercontent.com/35912840/108470535-7616cd00-72cd-11eb-940f-fd494da2a3ba.png)


```
"""QtXWindow
Inherits QtXWindow class and
implements set_ui method
using self.gen_{WIDGET_NAME}
"""
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QIcon
from PyQt5.QtWidgets import QApplication, QMainWindow
from PyQt5X.errors import *

class QtXWindow(QMainWindow):
    """Extended QMainWindow
    @parm:
        title: str, title of window
        icon_path: str, path to icon of window
    """
    app = QApplication([])
    def __init__(self, title, icon_path=None, width=None, height=None, resizable=True, style_path=None):
        super().__init__()
        self.setWindowTitle(title)
        self.setAutoFillBackground(True)
        if icon_path:
            self.setWindowIcon(QIcon(icon_path))
        # size
        monitor = QtXWindow.app.desktop().screenGeometry()
        width, height = (width or 600), (height or 400)
        self.setGeometry(
            (monitor.width()-width)//2, (monitor.height()-height)//2,
            width, height) # center of monitor
        if not resizable:
            self.setFixedSize(width, height)
        # style
        if style_path:
            self.set_csstyle(css_file=style_path)

    def show(self):
        """display the window at monitor"""
        super().show()
        QtXWindow.app.exec_()

    def __enter__(self):
        """for 'with' context
        @return:
            window: QtXWindow, itself
        """
        self.show()
        return self

    def __exit__(self, *exc_info):
        """for 'with' context
        @parm:
            exc_info: type, value, traceback
        """
        return exc_info

    def set_csstyle(self, css_file=None, style_dict=None):
        """set style with css
        @parm:
            css_file: str, path to css style file
                * filename extension is must be '.css'
            style_dict: dict, css styles
        """
        try: # Prevents program termination due to styling.
            if not (css_file or style_dict):
                raise ParmEmptyError('css_file or style_dict is required')
            if css_file:
                try:
                    with open(css_file, 'r', encoding='utf-8') as style:
                        self.setStyleSheet(style.read())
                except FileNotFoundError:
                    raise ResourceError("No Style File: " + css_file)
            if style_dict:
                # TODO: parse dict and apply style
                pass

        except Error as err:
            print('Can not apply style\n', err)

    def set_translucent_background(self):
        """Set the background transparent"""
        self.setAttribute(Qt.WA_TranslucentBackground)
```

# 제목 1

## 제목 2

### 제목 3

#### 제목 4

##### 제목 5

###### 제목 6

####### 제목 7

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
