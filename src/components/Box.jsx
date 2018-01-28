import React, { Component } from 'react';
import {Link} from 'react-router-dom';
import Header from './Header.jsx';

class Item extends Component {
  render() {
    return (
      <div className="item">
        <div className="img">
          <img src={`./images/products/item${this.props.item.image}`}/>
        </div>
        <div className="details">
          <div className="title">
            {this.props.item.title}
          </div>
          <div className="description">
            {this.props.item.desc}
          </div>
        </div>
        <div className="qty">
          ${this.props.item.price}
        </div>
      </div>
    )
  }
}

class Box extends Component {
  render() {
    const items = [
      {image: '1.jpg', title: 'Bebelac Junior 3', desc: 'Bebelac Junior 3 Growing Up Formula 1-3 Years 400g', price: 200},
      {image: '5.jpeg', title: 'Heineken (6 Pack Bottles)', desc: 'Milupa Aptamil 3 Growing-up Formula for Toddlers 400g', price: 30},
      {image: '6.jpg', title: 'Pampers Swaddlers Newborn', desc: '240 Diapers', price: 80},
    ];

    return (
      <div className="box-page">
        <Header/>

        <div className="box-title">Box 1 - Bi-weekly</div>

        <div className="items">
          <Item item={items[0]}/>
          <hr/>
          <Item item={items[1]}/>
          <hr/>
          <Item item={items[2]}/>
        </div>

        <div className="confirm">
          <Link to='/checkout'>Confirm</Link>
        </div>
      </div>
    )
  }
}

export default Box;
