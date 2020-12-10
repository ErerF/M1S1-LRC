#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Dec  2 16:18:41 2019

@author: Zixuan FENG
         Fangzhou YE
"""
import LRC_TME8_definitions_Allen as allen

#Exo1.2
def transposeSet(S):
    res=set()
    for s in S:
        res.add(allen.transpose[s])
    return res

def symetrieSet(S):
    res = set()
    for s in S:
        res.add(allen.symetrie[s])
    return res

#Exo1.3
def compose(r1,r2):
    if r1=='=':
        return {r2}
    if r2=='=':
        return {r1}
    if (r1,r2) in allen.compositionBase:        
        return allen.compositionBase[(r1,r2)]
    else:
        r2t=allen.transpose[r2]
        r1t=allen.transpose[r1]
        if (r2t,r1t) in allen.compositionBase:
            return transposeSet(allen.compositionBase[(r2t,r1t)])
        else:
            r1s=allen.symetrie[r1]
            r2s=allen.symetrie[r2]
            if (r1s,r2s) in allen.compositionBase:
                return symetrieSet(allen.compositionBase[(r1s,r2s)])
            else:
                r2st=allen.transpose[r2s]
                r1st=allen.transpose[r1s]
                return symetrieSet(transposeSet(allen.compositionBase[(r2st,r1st)]))

print('-----------------------')
print('Question 1.3')
print('-----------------------')
print(compose('=','d'))
print(compose('m','d'))
print(compose('ot','>'))
print(compose('>','e'))
print(compose('ot','m'))

#Exo1.4
def compositionSet(S1,S2):
    res=set()
    for i in S1:
        for j in S2:
            res=res.union(compose(i,j))
    return res

print('-----------------------')
print('Question 1.4')
print('-----------------------')
print(compositionSet({'m','o'},{'dt','st','et','='}))

#Exo2
class Graph(object):
    def __init__(self, noeuds, relations):
        self.noeuds = noeuds
        self.relations = relations
            
    def getRelation(self,i,j):
        if (i,j) in self.relations.keys():
            return self.relations[(i,j)]
        else:
            return 0

    def propagation(self, i, j):
        new_rel = self.relations
        new_rel[(i, j)] = self.getRelation(i, j)
        for n in self.noeuds:
            if i != n and j != n:
                Rin = self.getRelation(i, n)
                Rjn = self.getRelation(j, n)
                Rni = self.getRelation(n, i)
                Rnj = self.getRelation(n, j)
                if Rin == 0:
                    if self.getRelation(n, i) != 0:
                        Rin = transposeSet(self.getRelation(n, i))
                    else:
                        Rin = set()
                if Rjn == 0:
                    if self.getRelation(n, j) != 0:
                        Rjn = transposeSet(self.getRelation(n, j))
                    else:
                        Rjn = set()
                if Rni == 0:
                    if self.getRelation(i, n) != 0:
                        Rni = transposeSet(self.getRelation(i,n))
                    else:
                        Rni = set()
                if Rnj == 0:
                    if self.getRelation(j, n) != 0:
                        Rnj = transposeSet(self.getRelation(j,n))
                    else:
                        Rnj = set()
                composeR = compositionSet(self.getRelation(i, j), Rjn)
                new_rel[(i, n)] = Rin & composeR 
                composeR = compositionSet(self.getRelation(i, j), Rni)
                new_rel[(n, j)] = Rnj & composeR
        self.relations = new_rel

    def ajouter(self, r, i, j):
        if (i, j) in self.relations.keys():
            self.relations[(i, j)] = self.relations[(i, j)] | r
        else:
            self.relations[(i, j)] = r

#Q4)
print('-----------------------')
print('Question 2.4')
print('-----------------------')
noeuds4 = {'A','B','C'}
relations4 = {
    ('A','B'):{'<'},
    ('A','C'):{'>'}
}           
G4 = Graph(noeuds4, relations4)
G4.ajouter({'='}, 'B', 'C')
print(G4.getRelation('B','C'))
G4.propagation('B','C')
print(G4.getRelation('A','B'))
print(G4.getRelation('A','C'))

#Q5)
print('-----------------------')
print('Question 2.5 & Question 2.6')
print('-----------------------')
noeuds56 = {'S','L','R'}
relations56 = {
    ('L','S'):{'ot','mt'},
    ('L','R'):{'<','>','o','m','dt','s','st','et','='},
    ('S','R'):{'<','>','m','mt'}
} 
G56 = Graph(noeuds56, relations56)
G56.ajouter({'d'},'L','R')
print(G56.getRelation('L','R'))
G56.propagation('L','R')
print(G56.getRelation('S','R'))
print(G56.getRelation('L','R'))
print(G56.getRelation('L','S'))

#7)
print('-----------------------')
print('Question 2.7')
print('-----------------------')
noeuds7 = {'D','P','J','C'}
relations7 = {
    ('J','D'):{'o','et','dt','s','=','st','d','e','ot'},
    ('D','P'):{'<','m'},
    ('J','C'):{'e','=','et'}
}
G7 = Graph(noeuds7, relations7)
G7.ajouter({'=','e','d','s'}, 'C', 'D')
print(G7.getRelation('J','D'))
G7.propagation('C','D')
print(G7.getRelation('J','D'))
print(G7.getRelation('J','C'))
print(G7.getRelation('D','P'))