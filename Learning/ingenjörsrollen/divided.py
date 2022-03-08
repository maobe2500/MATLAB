#!/usr/bin/env python3
import matplotlib.pyplot as plt



def P(x):
    return 102 + 3*x + 2*x**2 + x**3

def plot_poly(x, y_data, y_fit):
    fig, ax = plt.subplots()
    ax.scatter(x, y_data, color='green', label='Given data')
    ax.plot(x, y_fit, color='orange', label='Anpassat polynom')
    ax.legend()
    plt.show()

def divDiff(x,Y):
    diffs = []
    for i in range(len(Y)-1):
        diffs.append((Y[i+1] - Y[i])/(x+1))
    return diffs[0], diffs 

def main():
    Y = [102, 108, 124, 156, 210, 292, 408, 564]
    steps = 0
    y_data = Y
    firsts = [102]
    for i in range(len(y_data[steps:])):

        if sum(y_data) == len(y_data):
            break

        first, diffs = divDiff(i, y_data)
        y_data = diffs
        steps += 1
        if first != 0:
            firsts.append(first)
    print(firsts)

    x = range(len(Y))
    y = [P(x) for x in x]
    plot_poly(x, Y, y)

main()


"""
    poly = "P(x) = "
    string = "(x-0)(x-1)(x-2)"
    for i in range(len(firsts)):
        addon = string[:i*5]
        if i != 0:
            poly += f' + {int(firsts[i])}'
        else:
            poly += f'{int(firsts[i])}'
        poly += addon
    print(poly)
""" 

#matrix = [[0 for _ in range(5)] for _ in range(5)]
#print(matrix)

# Matlab plot
# % P(x) = 102 + 3x + 2x^2 + x^3
# fplot(@(x) 102+3*x+2*x.^2+x.^3)
# xlim([0,7])
# xlabel('x values')
# ylabel('y values')
# title('Beast Graph')


# P(x) = 102 + 6(x-0) + 5(x-0)(x-1) + (x-0)(x-1)(x-2)
# P(x) = 102 + 6x + 5x^2 - 5x + x(x^3-3x^2+2x)
# P(x) = 102 + 3x + 2x^2 + x^3

"""
X    Y      dY      d2Y     d3Y
0   102     -       -       -
1   108     6       -       -
2   124     16      5       -
3   156     32      8       1
4   210     54      11      1
5   292     82      14      1
6   408     116     17      1
7   564     156     20      1

"""