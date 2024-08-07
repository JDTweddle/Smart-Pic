import React from 'react';
import './Recognition.css';

const Recognition = ({ imageUrl, boxes, concepts }) => {
  // Helper function to generate a color hash based on the concept name
  const getColorHash = (name) => {
    const hash = name.split('').reduce((acc, char) => char.charCodeAt(0) + acc, 0);
    const hue = hash % 360; // Ensure hue stays within 0 to 359
    return `hsl(${hue}, 70%, 50%)`; // Use HSL color representation
  };

  // Render bounding boxes and concept labels
  return (
    <div className='center ma'>
      <div className='relative mt5'>
        <img id='inputimage' alt='Detected' src={imageUrl} width='600px' height='auto' />
        {boxes && concepts && boxes.length === concepts.length && boxes.map((box, index) => {
          const concept = concepts[index][0]; // Extract the first (and only) concept in the array
          const boxColor = getColorHash(concept.name);

          return (
            <div
              key={index}
              className='bounding-box'
              style={{
                top: box.topRow,
                right: box.rightCol,
                bottom: box.bottomRow,
                left: box.leftCol,
                position: 'absolute',
                borderColor: boxColor,
              }}
            >
              <p className="concept-label" style={{ backgroundColor: boxColor }}>
                {concept.name}
              </p>
            </div>
          );
        })}
      </div>
    </div>
  );
};

export default Recognition;

