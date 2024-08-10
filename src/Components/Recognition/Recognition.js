import React, { useState } from 'react';
import './Recognition.css';

const Recognition = ({ boxes, imageUrl, concepts }) => {
  const [hoveredIndex, setHoveredIndex] = useState(-1);

  const handleMouseEnter = (index) => {
    setHoveredIndex(index);
  };

  const handleMouseLeave = () => {
    setHoveredIndex(-1);
  };

  // Helper function to generate a unique color for each concept
  const getConceptColor = (conceptName) => {
    const hash = conceptName.split('').reduce((acc, char) => char.charCodeAt(0) + acc, 0);
    const hue = hash % 360;
    return `hsl(${hue}, 70%, 50%)`;
  };

  return (
    <div className="center ma">
      <div className="absolute mt2" style={{ position: 'relative' }}>
        {imageUrl && (
          <div className="image-container">
            <img id="inputimage" alt="" src={imageUrl} width="500px" height="auto" />
            {hoveredIndex !== -1 && (
              <div className="concept-name" style={{ backgroundColor: getConceptColor(concepts[hoveredIndex].name) }}>
                {concepts[hoveredIndex].name}
              </div>
            )}
          </div>
        )}
        {boxes.map((box, i) => (
          <div
            key={i}
            className={`bounding-box ${hoveredIndex === i ? 'visible' : ''}`}
            style={{
              top: box.topRow,
              right: box.rightCol,
              bottom: box.bottomRow,
              left: box.leftCol,
              border: `4px solid ${getConceptColor(concepts[i].name)}`,
            }}
            onMouseEnter={() => handleMouseEnter(i)}
            onMouseLeave={handleMouseLeave}
          />
        ))}
      </div>
    </div>
  );
};

export default Recognition;



