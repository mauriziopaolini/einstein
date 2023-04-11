import matplotlib.pyplot as plt
import math

phi=(1+math.sqrt(5))/2
sq3=math.sqrt(3)
ap=sq3/2

def trasf(l,alpha,x0,y0):
    x,y=[],[]
    for i in range(len(l[0])):
        a=alpha*math.pi/180
        x.append(l[0][i]*math.cos(a)-l[1][i]*math.sin(a)+x0)
        y.append(l[0][i]*math.sin(a)+l[1][i]*math.cos(a)+y0)
    return [x,y]

#tasx=[-5/2, -1/2, 0, 3/2, 3, 5/2, 3/2, 3/2, 0, -1/2, -3/2, -3/2, -3, -5/2]
#tasy=[-sq3/2, -sq3/2, 0, -sq3/2, 0, sq3/2, sq3/2, 3/2*sq3, 2*sq3, 3/2*sq3, 3/2*sq3, sq3/2, 0, -sq3/2]
hatx=[0, 3/4, 1/2, -1/2, -3/4, -3/2, -9/4, -2, -3/2, -3/2, -3/4, -1/2, 0, 0]
haty=[0, ap/2, ap, ap, ap/2, ap, ap/2, 0, 0, -ap, -3/2*ap, -ap, -ap, 0]

tahx=[-x for x in hatx]

#plt.fill(tahx,haty,color='#00aa0088')

def H7(c1,c2,c3):
    h=[]
    h.append([trasf([tahx,haty],120,0,0),c1])
    h.append([trasf([hatx,haty],60,3/2,ap),c2])
    h.append([trasf([hatx,haty],60,-3/2,ap),c2])
    h.append([trasf([hatx,haty],-60,0,2*ap),c2])
    h.append([trasf([hatx,haty],0,-3/2,3*ap),c3])
    h.append([trasf([hatx,haty],120,-3/2,-ap),c3])
    h.append([trasf([hatx,haty],180,0,-2*ap),c3])
    return h

def H8(c1,c2,c3):
    h=H7(c1,c2,c3)
    h.append([trasf([hatx,haty],60,-3,2*ap),c3])
    return h

c71=(1,0,0)
c72=(1,0.5,0.5)
c73=(1,0.75,0.75)
c81=(0,0,1)
c82=(0.5,0.5,1)
c83=(0.75,0.75,1)

#for l in H8(c71,c72,c73):
#    plt.fill(l[0][0],l[0][1],color=l[1])

def fibo(i):
    if i == 0 or i == 1:
        return 1
    else:
        return fibo(i-1)+fibo(i-2)

def lucas(i):
    if i == 0:
        return 2
    elif i == 1:
        return 1
    else:
        return lucas(i-1)+lucas(i-2)

def lucas31(i):
    if i == 0:
        return 3
    elif i == 1:
        return 1
    else:
        return lucas31(i-1)+lucas31(i-2)

    
def h7rec(trsf, depth):
    d = depth-1
    g=[]
    if depth == 0:
        for l in H7(c71,c72,c73):
            g.append([trasf(l[0],trsf[0],trsf[1],trsf[2]),l[1]])
        return g
    else:
        for l in h7rec(trsf,d):
            g.append([trasf(l[0],0,0,0),l[1]])
        for l in h8rec(trsf,d):
            g.append([trasf(l[0],0,-3/2*lucas(2*d+2),ap*fibo(2*d+1)),l[1]])
        for l in h8rec(trsf,d):
            g.append([trasf(l[0],-120,-3*fibo(2*d+1),ap*2*lucas(2*d+2)),l[1]])
        for l in h8rec(trsf,d):
            g.append([trasf(l[0],60,-3/2*fibo(2*d+2),-ap*lucas31(2*d+2)),l[1]])
        for l in h8rec(trsf,d):
            g.append([trasf(l[0],120,3/2*fibo(2*d),-ap*(fibo(2*d+2)+lucas(2*d+2))),l[1]])
        for l in h8rec(trsf,d):
            g.append([trasf(l[0],-60,-3/2*fibo(2*d+4),ap*(2*fibo(2*d+2)+lucas(2*d+2))),l[1]])
        return g

def h8rec(trsf, depth):
    d = depth-1
    g=[]
    if depth == 0:
        for l in H8(c81,c82,c83):
            g.append([trasf(l[0],trsf[0],trsf[1],trsf[2]),l[1]])
        return g
    else:
        for l in h7rec(trsf,d):
            g.append([trasf(l[0],0,0,0),l[1]])
        for l in h8rec(trsf,d):
            g.append([trasf(l[0],0,-3/2*lucas(2*d+2),ap*fibo(2*d+1)),l[1]])
        for l in h8rec(trsf,d):
            g.append([trasf(l[0],0,-3/2*lucas(2*d+4),ap*fibo(2*d+3)),l[1]])
        for l in h8rec(trsf,d):
            g.append([trasf(l[0],-120,-3*fibo(2*d+1),ap*2*lucas(2*d+2)),l[1]])
        for l in h8rec(trsf,d):
            g.append([trasf(l[0],60,-3/2*fibo(2*d+2),-ap*lucas31(2*d+2)),l[1]])
        for l in h8rec(trsf,d):
            g.append([trasf(l[0],120,3/2*fibo(2*d),-ap*(fibo(2*d+2)+lucas(2*d+2))),l[1]])
        for l in h8rec(trsf,d):
            g.append([trasf(l[0],-60,-3/2*fibo(2*d+4), ap*(2*fibo(2*d+2)+lucas(2*d+2))),l[1]])
        return g

for l in h7rec([0,0,0],3):
    plt.fill(l[0][0],l[0][1],color=l[1])
    plt.plot(l[0][0],l[0][1],'k')


plt.show()
