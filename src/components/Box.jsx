import React, { Component } from 'react';
import {Link} from 'react-router-dom';
import Header from './Header.jsx';

class Item extends Component {
  render() {
    return (
      <div className="item">
        <div className="img">
          <img src="./images/products/item1.jpg"/>
        </div>
        <div className="details">
          <div className="title">
            FRISO 3 GOLD 900 G
          </div>
          <div className="description">
            simple dummy text simple dummy text simple dummy text simple dummy text
          </div>
        </div>
        <div className="qty">
          $80
        </div>
      </div>
    )
  }
}

class Box extends Component {
  render() {
    return (
      <div className="box-page">
        <Header/>

        <div className="items">
          <Item/>
          <hr/>
          <Item/>
          <hr/>
          <Item/>
          <hr/>
          <Item/>
        </div>

        <div className="confirm">
          <Link to='/checkout'>Confirm</Link>
        </div>
      </div>
    )
  }
}

export default Box;
