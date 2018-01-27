import React, { Component } from 'react';
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
      </div>
    )
  }
}

export default Checkout;
