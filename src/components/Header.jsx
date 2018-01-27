import React, { Component } from 'react';
import {Link} from 'react-router-dom';

class Header extends Component {
  render() {
    return (
      <div className="header">
        <div className="left">
          <Link to='/'>
            <img className="title" src="./images/nav-menu.png"/>
          </Link>
        </div>
        <div className="center">
          <img className="title" src="./images/nav-title.png"/>
        </div>
        <div className="right">
          <img className="title" src="./images/nav-avatar.png"/>
        </div>
      </div>
    )
  }
}

export default Header;
