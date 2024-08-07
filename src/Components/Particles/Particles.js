import React from 'react';
import ParticlesBg from 'particles-bg';
import './Particles.css';

const Particles = () => {
  return (
    <div>
      <ParticlesBg color='#000000' num={50} type='cobweb' bg={true} />
    </div>
  );
};

export default Particles;
