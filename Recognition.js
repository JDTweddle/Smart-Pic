import React from 'react';
import './Recognition.css';

const Recognition = ({ boxes, imageUrl, concepts }) => {
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
            <img id="inputimage" alt="" src={imageUrl} width="700px" height="auto" />
          </div>
        )}
        {boxes.map((box, i) => (
          <React.Fragment key={i}>
            <div
              className="bounding-box"
              style={{
                top: box.topRow,
                right: box.rightCol,
                bottom: box.bottomRow,
                left: box.leftCol,
                border: `4px solid ${getConceptColor(concepts[i].name)}`,
              }}
            />
            <div 
              className="concept-name" 
              style={{ 
                backgroundColor: getConceptColor(concepts[i].name),
                position: 'absolute',
                top: `${box.topRow - 3}px`,
                left: `${box.leftCol+8}px`,
                padding: '1px 1px',
                fontSize: '13px',
                borderRadius: '4px',
                boxShadow: '0 0 5px rgba(0, 0, 0, 0.3)',
                fontFamily: 'Arial, sans-serif',
                fontWeight: 'bold',
                color: 'white',
                whiteSpace: 'wrap',
              }}
            >
              {concepts[i].name}
            </div>
          </React.Fragment>
        ))}
      </div>
    </div>
  );
};

export default Recognition;



