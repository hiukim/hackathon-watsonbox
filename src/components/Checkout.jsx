import React, { Component } from 'react';
import {Link} from 'react-router-dom';
import Header from './Header.jsx';

class Checkout extends Component {
  render() {
    return (
      <div className="checkout-page">
        <Header/>
        <div className="title">
          <p>Great!</p>
          <p>Your box is on the way</p>
        </div>
        <img className="delivery" src="./images/delivery.png"/>
        <div className="details">
          <p>Delivery #: <span className="number">3215465</span></p>
        </div>

        <div className="back">
          <Link to='/home'>Back to Shopping</Link>
        </div>
      </div>
    )
  }
}

export default Checkout;
