import React, { Component } from 'react';
import {Link} from 'react-router-dom';
import Header from './Header.jsx';

class Box extends Component {
  renderItem() {
    return (
      <div className="item">
        <img src="./images/products/item1.jpg"/>
      </div>
    )
  }

  render() {
    return (
      <div className="box">
        <Link to='/box'>
          <div className="title">Box 1</div>
          <div className="items">
            {this.renderItem()}
            {this.renderItem()}
            {this.renderItem()}
          </div>
        </Link>
      </div>
    )
  }
}

class Home extends Component {
  render() {
    return (
      <div className="home">
        <Header/>
        
        <div>
          <img className="title" src="./images/box.png"/>
          <p>Select your Box</p>
        </div>

        <div className="box">
          <div className="title">Box 1</div>
          <Link to='/box'>
            <img src="./images/box1.jpg"/>
          </Link>
        </div>
        <div className="box">
          <div className="title">Box 2</div>
          <Link to='/box'>
            <img src="./images/box2.png"/>
          </Link>
        </div>
        <div className="box">
          <div className="title">Box 3</div>
          <Link to='/box'>
            <img src="./images/box3.png"/>
          </Link>
        </div>

        <div className="box">
          <div className="title">Box 4</div>
          <Link to='/box'>
            <img src="./images/box1.jpg"/>
          </Link>
        </div>
        <div className="box">
          <div className="title">Box 5</div>
          <Link to='/box'>
            <img src="./images/box2.png"/>
          </Link>
        </div>
        <div className="box">
          <div className="title">Box 6</div>
          <Link to='/box'>
            <img src="./images/box3.png"/>
          </Link>
        </div>
      </div>
    )
  }
}

export default Home;
