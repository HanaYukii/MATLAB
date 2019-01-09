import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy.io import loadmat

data = loadmat('data/hw4.mat')
from sklearn.preprocessing import OneHotEncoder
encoder = OneHotEncoder(sparse=False)
y_onehot = encoder.fit_transform(data['y'])
    
def sigmoid(z):
    return 1 / (1 + np.exp(-z))
    
def forward_propagate(X, theta1, theta2):
    m = X.shape[0]
    b=np.ones((m,1))
    act=lambda i:sigmoid(i)
    v=np.vectorize(act)
    a1 =np.concatenate((b, X), axis=1)
    z2 =np.dot(a1, theta1.transpose())
    a2 =np.concatenate((b, v(z2)), axis=1)
    z3 =np.dot(a2,theta2.transpose())
    h = v(z3)
    return a1, z2, a2, z3, h
    
def cost(params, input_size, hidden_size, num_labels, X, y, learning_rate):
    m = X.shape[0]
    X = np.matrix(X)
    y = np.matrix(y)
    # reshape the parameter array into parameter matrices for each layer
    theta1 = np.matrix(np.reshape(params[:hidden_size * (input_size + 1)], (hidden_size, (input_size + 1))))
    theta2 = np.matrix(np.reshape(params[hidden_size * (input_size + 1):], (num_labels, (hidden_size + 1))))
    # run the feed-forward pass
    a1, z2, a2, z3, h = forward_propagate(X, theta1, theta2)
    # compute the cost
    J = 0
    for i in range(m):
        first_term = np.multiply(-y[i,:], np.log(h[i,:]))
        second_term = np.multiply((1 - y[i,:]), np.log(1 - h[i,:]))
        J += np.sum(first_term - second_term)
        
    J = J / m
    J += (float(learning_rate) / (2*m) * (np.sum(np.power(theta1[:,1:], 2)) + np.sum(np.power(theta2[:,1:], 2))))   
    return J
    
# initial setup
input_size = 400
hidden_size = 10
num_labels = 10
learning_rate = 1
# randomly initialize a parameter array of the size of the full network's parameters
params = (np.random.random(size=hidden_size * (input_size + 1) + num_labels * (hidden_size + 1)) - 0.5) * 0.2
m = data['X'].shape[0]
X = np.matrix(data['X'])
y = np.matrix(data['y'])
# unravel the parameter array into parameter matrices for each layer
theta1 = np.matrix(np.reshape(params[:hidden_size * (input_size + 1)], (hidden_size, (input_size + 1))))
theta2 = np.matrix(np.reshape(params[hidden_size * (input_size + 1):], (num_labels, (hidden_size + 1))))

a1, z2, a2, z3, h = forward_propagate(X, theta1, theta2)

def sigmoid_gradient(z):
    return np.multiply(sigmoid(z), (1 - sigmoid(z)))    

def backprop(params, input_size, hidden_size, num_labels, X, y, learning_rate):
    m = X.shape[0]
    t1=np.matrix(np.reshape(params[:hidden_size * (input_size + 1)], (hidden_size, (input_size + 1))))
    t2=np.matrix(np.reshape(params[hidden_size * (input_size + 1):], (num_labels, (hidden_size + 1))))
    nt1= np.delete(t1, 0, axis = 1)
    nt2= np.delete(t2, 0, axis = 1)
    act= lambda i : sigmoid(i)
    v= np.vectorize(act)
    learn=lambda i : ((i*learning_rate) / m)
    vlearn= np.vectorize(learn)
    agrad = lambda i : sigmoid_gradient(i)
    vgrad= np.vectorize(agrad)
    d1=np.zeros(t1.shape)
    d2=np.zeros(t2.shape)
    for i in range(0, m):
        b= np.ones((1,1)) 
        a1 = np.concatenate((b, X[i].transpose()), axis = 0)
        z2 = np.dot(t1, a1)
        a2 = np.concatenate((b, v(z2)), axis=0)
        z3 = np.dot(t2, a2)
        h = v(z3)
        d3 = np.subtract(h, y[i].reshape(10, 1))
        d4 = np.multiply(np.dot(nt2.transpose(), d3), vgrad(z2))
        d1 += np.dot(d4, a1.transpose())
        d2 += np.dot(d3, a2.transpose())
        

    t1grad = vlearn(d1)
    t2grad = vlearn(d2)
    grad = np.concatenate((t1grad.flatten(), t2grad.flatten()), axis = 0)
    J = cost(params, input_size, hidden_size, num_labels, X, y, learning_rate)
    return J, grad
    
from scipy.optimize import minimize
# minimize the objective function
fmin = minimize(fun=backprop, x0=params, args=(input_size, hidden_size, num_labels, X, y_onehot, learning_rate), method='TNC', jac=True, options={'maxiter': 250})
X = np.matrix(X)
theta1 = np.matrix(np.reshape(fmin.x[:hidden_size * (input_size + 1)], (hidden_size, (input_size + 1))))
theta2 = np.matrix(np.reshape(fmin.x[hidden_size * (input_size + 1):], (num_labels, (hidden_size + 1))))
a1, z2, a2, z3, h = forward_propagate(X, theta1, theta2)
y_pred = np.array(np.argmax(h, axis=1) + 1)

correct = [1 if a == b else 0 for (a, b) in zip(y_pred, y)]
accuracy = (sum(map(int, correct)) / float(len(correct)))

print ('accuracy = {0}%'.format(accuracy * 100))