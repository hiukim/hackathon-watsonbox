import React, { Component } from 'react';
import logo from './logo.svg';
import Home from './components/Home.jsx';
import List from './components/List.jsx';
import Checkout from './components/Checkout.jsx';
import {Switch, Route, Link} from 'react-router-dom';
import './App.css';

class App extends Component {
  render() {
    return (
      <div>
        <div className="ui menu">
          <Link className="active item" to='/'>Title</Link>
        </div>
        <Switch>
          <Route exact path='/' component={Home}/>
          <Route exact path='/list' component={List}/>
          <Route exact path='/checkout' component={Checkout}/>
        </Switch>
      </div>
    );
  }
}

export default App;
