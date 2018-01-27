import React, { Component } from 'react';
import logo from './logo.svg';
import Landing from './components/Landing.jsx';
import Home from './components/Home.jsx';
import Box from './components/Box.jsx';
import Checkout from './components/Checkout.jsx';
import {Switch, Route, Link} from 'react-router-dom';
import './App.css';

class App extends Component {
  render() {
    return (
      <div className="app">
        <Switch>
          <Route exact path='/' component={Landing}/>
          <Route exact path='/home' component={Home}/>
          <Route exact path='/box' component={Box}/>
          <Route exact path='/checkout' component={Checkout}/>
        </Switch>
      </div>
    );
  }
}

export default App;
