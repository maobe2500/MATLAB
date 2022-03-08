#!/usr/bin/env python3
import matplotlib.pyplot as plt

"""
    Dessa krav måste vara uppfyllda:

    Det finns ett ändlig antal tillstånd som kan besättas vid varje tidpunkt.
    •Tillstånden överlappar inte och täcker alla möjliga utfall.
    •Systemet kan ändras från ett till ett annat tillstånd vid varje tidsteg.
    •För varje möjligt utfall finns det en sannolikhet med vilken övergången till ett annat
    tillstånd sker.
    •Summan av sannolikheterna för övergången från det nuvarande tillståndet till nästa är
    lika med 1 för varje tidpunkt

"""

def markov(A, B, p, q, max_iter, i=0, A_list=[], B_list=[]):
    A_next = p*A + (1-q)*B
    B_next = q*B + (1-p)*A
    A_list.append(A); B_list.append(B)
    print('{:^20}{:^20}'.format(f'A: {round(A, 5)},',f'B: {round(B, 5)}'))
    if i >= max_iter:
        return A_list, B_list
    return markov(A_next, B_next, p, q, max_iter, i+1, A_list, B_list)


def main():
    max_iter = 10
    A = 1; B = 0; p = 0.55; q=0.60
    A_list, B_list = markov(A,B, p, q, max_iter)

    x = range(max_iter+1)
   
    fig, ax = plt.subplots()
    ax.plot(x, A_list, color='green', label='Soligt')
    ax.plot(x, B_list, color='orange', label='Regnigt')
    ax.legend()
    plt.show()

main()



"""
# övergångsmatris
[[0.6, 0.4],
[0.45, 0.55]]
[["q", ("1-q")],    ["A"]       "qA + (1-q)B"
[("1-p"), "p"]]     ["B"]       "(1-p)A + pB"

"""