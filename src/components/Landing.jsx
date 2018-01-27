import React, { Component } from 'react';
import {Link} from 'react-router-dom';

class Landing extends Component {
  render() {
    return (
      <div className="landing">
        <img className="title" src="./images/landing-title.png"/>

        <div className="footer">
          <Link to='/home'>Explore</Link>
        </div>
      </div>
    )
  }
}

export default Landing;
