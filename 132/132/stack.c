//
//  stack.c
//  132
//
//  Created by fanyl on 2020/7/29.
//  Copyright © 2020 fanyl. All rights reserved.
//

#include "stack.h"

#include <stdlib.h>

Status initStack(Stack *s) {
    s->base = (Element *)malloc(STACK_SIZE * sizeof(Element));
    if (!s->base) {
        return ERROR;
    }
    s->top = s->base;
    s->stackSize = STACK_SIZE;
    return OK;
}

Status emptyStack(Stack *s) {
    if (s->top == s->base) {
        return TRUE;
    }
    else {
        return ERROR;
    }
}

Status pushStack(Stack *s, Element e) {
    if (s->top - s->base >= STACK_SIZE) {
        s->base = (Element *)realloc(s->base, sizeof(Element) * s->stackSize + STACK_INCREMENT);
        if (!s->base) {
            return ERROR;
        }
        s->top = s->base + s->stackSize;
        s->stackSize = s->stackSize + STACK_INCREMENT;
    }
    
    *s->top++ = e;
    return OK;
}

Status popStack(Stack *s, Element *e) {
    if (s->top == s->base) {
        return ERROR;
    }
    *e = *--s->top;
    return OK;
}

Status topStack (Stack *s, Element *e) {
    if (s->top == s->base) {
        return ERROR;
    }
    *e = *(s->top-1);
    return OK;
}
