import React from 'react';

const Navigation = ({ onRouteChange, isSignedIn }) => {
  if (isSignedIn) {
    return (
      <nav style={{ display: 'flex', justifyContent: 'flex-end', padding: '10px' }}>
        <p onClick={() => onRouteChange('signout')} className='f3 link black underline pa3 grow pointer'>
          <button className='b f4 bg-transparent sign-out-button'>Sign Out</button>
        </p>
      </nav>
    );
  } else {
    return null;
  }
};

export default Navigation;
