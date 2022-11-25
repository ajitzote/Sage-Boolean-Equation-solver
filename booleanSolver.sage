#!/usr/bin/env sage

import sys
#sys.setrecursionlimit(10000)
from sage.all import *
from random import *

B=BooleanPolynomialRing(8,'x')
B.inject_variables()
f=x1+x5*x4*x7+x2*x3+1
g=x0+x3
h=x3+x4*x1
t=x0*x1*x2+x3
#g=(1+x0*x1+x2*x3+x4*x5+x6*x7)
#h=x2+x3+x4
final=f*g*h*t


#implicants = []
#a=q.args()

#for i in range(len(a)+1):
#    d1 = {}
#    if(i<=len(a)-1):
#        d1[q.args()[i]] = 1
#    for j in range(1,i+1):
#        d1[q.args()[i-j]] = 0 
       
#    implicants.append(d1)

#print(implicants)

def find_implicants(expression):
        implicants = []
        a=expression.variables()

        for i in range(len(a)+1):
            d1 = {}
            if(i<=len(a)-1):
                d1[expression.variables()[i]] = 1
            for j in range(1,i+1):
                d1[expression.variables()[i-j]] = 0 
       
            implicants.append(d1)
        return implicants


def function(expression):
        list=[]
        #print(expression)
        implicants = find_implicants(expression)
        #print(implicants)
        a=expression.variables()
        l=len(a)
        for j in range(l+1):
            value=expression.subs(implicants[j])
            #print("after substituting")
            #print(implicants[j])
            #print("we got")
            #print(value)
            if value==1 :
                #print("it went inside 1")
                list.append(implicants[j])
            elif value==0:
                #print("it went inside 0")
                continue  
            else :
                #print("its going to go inside the function")
                list_of_inside_implicant=function(value)
                #print("it came back and we got the list")
                length=len(list_of_inside_implicant)  
        	for k in range(length):
                    list_of_inside_implicant[k].update(implicants[j])
                list=list+list_of_inside_implicant
                #print(list)
        return list

#
#print(find_implicants(t))
#print(ans)
 
def find_answer(expression,list):
        new_list=[]
        a=len(list)
        for i in range(a):
            value=expression.subs(list[i])
            if value==1 :
                new_list.append(list[i])
            elif value==0 :
                continue
            else :
                implicants_of_this_fn=function(value)
                imp_len=len(implicants_of_this_fn)
                for m in range(imp_len):
                    implicants_of_this_fn[m].update(list[i])
                new_list=new_list+implicants_of_this_fn
        return new_list
new_answer_after_putting_earlier_implicants=[]
list_of_expressions=[f,g,h,t]
No_functions=len(list_of_expressions)
ans=function(final)
#print(ans)
#final_answer=find_answer(g,ans)
#print(final_answer)
for i in range(No_functions):
    if i==0:
        ans=function(list_of_expressions[i])
    if i==1:
        new_answer_after_putting_earlier_implicants=find_answer(list_of_expressions[i],ans)
    else:
        new_answer_after_putting_earlier_implicants=find_answer(list_of_expressions[i],new_answer_after_putting_earlier_implicants)
print(new_answer_after_putting_earlier_implicants)
len_of_fin_ans=len(new_answer_after_putting_earlier_implicants)
for i in range(len_of_fin_ans):
    k=final.subs(new_answer_after_putting_earlier_implicants[i])
    print(k)




#print(find_implicants(h))













end
