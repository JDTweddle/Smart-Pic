import React from 'react';
import icon from './icon.png';
import './Logo.css'; // Import the CSS file for styling

const Logo = () => {
    return (
        <div className='perspective-container'>
            <div className='flip-animation'>
                <img
                    alt='Company Logo'
                    src={icon}
                    className='logo-img'
                />
            </div>
        </div>
    );
};

export default Logo;