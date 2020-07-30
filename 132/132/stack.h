//
//  stack.h
//  132
//
//  Created by fanyl on 2020/7/29.
//  Copyright © 2020 fanyl. All rights reserved.
//

#ifndef stack_h
#define stack_h

#include <stdio.h>

typedef int Element;

#define STACK_SIZE 100
#define STACK_INCREMENT 10

#define OK 1
#define TRUE 1
#define ERROR 0

typedef int Status;

typedef struct {
    Element *base; // 底
    Element *top; // 顶
    int stackSize;
} Stack;

Status initStack(Stack *s);
Status emptyStack(Stack *s);
Status pushStack(Stack *s, Element e);
Status popStack(Stack *s, Element *e);
Status topStack (Stack *s, Element *e);

#endif /* stack_h */
