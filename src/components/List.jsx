import React, { Component } from 'react';
import {Link} from 'react-router-dom';

class List extends Component {
  render() {
    return (
      <div>
        <h1>List</h1>
        <Link to='/checkout'>check out</Link>
      </div>
    )
  }
}

export default List;
