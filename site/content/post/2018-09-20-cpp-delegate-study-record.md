---
title: "C++ Delegate学习记录"
date: 2018-09-27
draft: false
categories: ["Lorem"]
# slug: "dotscale-2014-as-a-sketch"
tags: ["C++","Delegate"]
comments: true     # set false to hide Disqus comments
 share: true        # set false to share buttons
# menu: "123"           # set "main" to add this content to the main menu
---
# C++ Delegate学习记录

## 起因

看同事代码，看到Delegate相关，有点好奇为何不直接用
[std::function](https://en.cppreference.com/w/cpp/utility/functional/function)
而要自己封装一个，想来应该有原因的。虽然以前开发用C++,但近几年一直在开发手游，C++11相关也不是很熟悉，就把自己学习做一个记录。

## 为何要重复造轮子

想来应该是
[std::function](https://en.cppreference.com/w/cpp/utility/functional/function)
没有办法满足大家的需求，我大概总结一下，无非以下几点原因：

  - 是否要求动态分配内存

  - 是否可比较，方便写事件系统

  - 语法是否使用舒服

  - 是否支持lambda新的语法

  - 性能问题

## 个人选择

就本人来说，还是倾向于直接使用
[std::function](https://en.cppreference.com/w/cpp/utility/functional/function)：

  - 是否要求动态分配内存:
    
      - 就像 [What you need *not* know about
        std::function](http://templated-thoughts.blogspot.com/2016/09/what-you-need-not-know-about.html)
        里所说的，各个编译器的实现肯定会做SBO (Small Buffer Optimization),
        所以一般是不会有动态分配的，只有超过这个buffer大小,才需要动态分配

  - 是否可比较，方便写事件系统:
    
      - 不可比较,的确是function的\*主要缺点\*，但是可以类似于boost::signal,一样可以实现想要的功能，所以并不算一个大问题

  - 语法糖: 强大语法

  - 是否支持lambda新的语法: 支持

  - 性能问题: [std::function Performance
    benchmarks](http://templated-thoughts.blogspot.com/2016/10/what-you-need-not-know-about.html)
    的测试表现并没有性能问题

## 各种实现

### 前C++ 11时代

  - [FastDelegate](https://www.codeproject.com/Articles/7150/Member-Function-Pointers-and-the-Fastest-Possible):
    
      - 虽然写法比较hack,但是非常好用，而且对底层的成员函数指针实现，也有比较透彻的解释。

  - [The Impossibly Fast C++
    Delegates](https://www.codeproject.com/Articles/11015/The-Impossibly-Fast-C-Delegates):
    
      - 对
        [FastDelegate](https://www.codeproject.com/Articles/7150/Member-Function-Pointers-and-the-Fastest-Possible)主要改进就是不需要动态内存分配，但语法层面就不怎么友好了，个人不是很喜欢

  - [Fast C++
    Delegate](https://www.codeproject.com/Articles/13287/Fast-C-Delegate):
    
      - 对前述几个Delegate的做了一定改进

### C++ 11时代

  - [std::function](https://en.cppreference.com/w/cpp/utility/functional/function)
    : C++ 11开始，由标准库提供的，强大的语法及功能

  - [The Impossibly Fast C++ Delegates
    Fixed](https://www.codeproject.com/Articles/1170503/The-Impossibly-Fast-Cplusplus-Delegates-Fixed):
    
      - 用C++ 11对 [The Impossibly Fast C
        Delegates](https://www.codeproject.com/Articles/11015/The-Impossibly-Fast-C-Delegates)的重新实现

### 实现的Code Review

  - [C++ delegate implementation with member
    functions](https://codereview.stackexchange.com/questions/36251/c-delegate-implementation-with-member-functions):
    
      - 目前项目的代码就是基于这个实现来改进， code review的人不但点评的很精彩，提供的几个实现也非常好

  - [Impossibly fast delegate in
    C++11](https://codereview.stackexchange.com/questions/14730/impossibly-fast-delegate-in-c11):
    
      - [The Impossibly Fast C++
        Delegates](https://www.codeproject.com/Articles/11015/The-Impossibly-Fast-C-Delegates)的C++
        11的实现

## 性能比较

  - [C++ Delegate Library
    Collection](https://github.com/yxbh/Cpp-Delegate-Library-Collection):
    
      - 对前面提到的好几个库做了性能比较

  - [std::function Performance
    benchmarks](http://templated-thoughts.blogspot.com/2016/10/what-you-need-not-know-about.html):
    
      - 测试std::function的性能, 进一步论证了function的性能还是可以的

  - [C++ Delegate Libraries Performance
    Benchmark](http://www.mcshaffry.com/GameCode/index.php/Thread/1990-C-Delegate-Libraries-Performance-Benchmark):
    
      - 虽然他这里的测试结果std::function性能不怎么样，但是我用他的测试代码在VS2017+Releae的情况下，测试结果几乎差不多
