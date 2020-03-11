% Multivariable Toolbox
% Version 1.0 (R2007a) 15-Jun-2008
%

% No Minimal Realizations
%   gilbertform   - Finds the Gilbert form of a LTI MIMO SYS model.
%   hoform        - Finds the Ho canonical form of a LTI MIMO SYS model. 
%   jordanform    - Finds the Jordan form of a LTI MIMO SYS model.
%   exjordanform  - Finds the extended Jordan form of a LTI MIMO SYS model.
%   wolovichform  - Realization by method Wolovich of a LTI MIMO SYS model.
%   rmpf2ss       - Find the realization by method fraction coprime of  a MPF.
%   lmpf2ss       - Finds the  realization by method fraction coprime of a LTI
%   dssdata       -Extract descriptor state-space data*.
%   ssdata        -Access state-space model data*.
%   canon         -State-space canonical realization*. 
%
%
% Minimal Realization.
%   minhoform     - Finds the Minimal realization by method Ho.
%   minjordanform - Finds the Minimal realization by method irreducible Jordan.
%   gauthierform  - Gauthier minimal algoritm of a MPF model.
%   rcfform       - Finds the minimal realization by method right fraction coprime.
%   lcfform       - Finds the minimal realization by method fraction left coprime.
%   silvermanform - Finds the minimal realization by method Silverman.
%   minreal       -Minimal realization*.
%
%
% Conversions
%   ss2mtf        - Convert state-space filter parameters to Matrix Transfer Function.
%   ss2lmpf       - State-space to Left Matrix Polynomial Fraction.
%   ss2rmpf       - State-space to Right Matrix Polynomial Fraction. 
%   mtf2lmpf      - Matrix Transfer Function to Left Matrix Fraction Description.
%   mtf2rmpf      - Matrix Transfer Function to Right Matrix Polynomial Fraction.
%   mtf2lcf       - Matrix Transfer Function to Left Coprime Fraction. 
%   mtf2rcf       - Matrix Transfer Function to Right Coprime Fraction. 
%   rcf2mtf       - Right Coprime Fraction to Matrix Transfer Function.
%   lcf2mtf       - Left Coprime Fraction to Matrix Transfer Function.
%
%
% MPF Characteristics 
%   findv         - Find the blocks in matrix Jordan or the indices of MPF.
%   iscolred      - Determine if the MPF  is column reduced.
%   isrowred      - Determine is the MPF is row reduced.
%   mSilvester    - Find the Matrix Silvester.
%   lmpf          - 23 Examples in Left MPF Format cell.
%   mpfred        - Finds the minimal reduction of MPF.
%   islmpfc       - Determine if the left MPF  is controlable.
%   isrmpfo       - Determine if the Right MPF  is observable.
%   uplowM        - Find the matrices with the hight and low coeficients.
%
%
% MTF Characteristics 
%   mtfsp         - Strictly Proper Matrix Transfer Function. 
%   mindeg        - Degree minimal of LTI MIMO SYS model.
%   mresidue      - Partial fraction expansion of Matrix Transfer Function.
%   mtf           - 71 MTF Examples. 
%   rga           - Finds the RGA (relative gain array) of an LTI MIMO SYS model**.
%   polezero      - Pole and zeros of LTI MIMO SYS model.
%   smform        - Finds the Smith-McMillan form of a LTI MIMO SYS model**.
%
%
% State Space Characteristics
%   coXm          - Check the observability and controlability for mode. 
%   polindex      - Finds the index of Polynomial characteristic and the minimal. 
%   state         - state 45 examples in space-state. 
%   isctrb        - Determine if the state-space  is controlable. 
%   ss            -Specify state-space models or convert LTI model to state space*.
%   jordan        -Jordan canonical form*.
%   gram          -Controllability and observability grammians*.
%
%
% Similarity Transformation
%   canonform     - Find a observability and controlability canonical form.
%   cx2rJ         - Complex to real Jordan format. 
%   ss2ss         -State coordinate transformation for ss model*. 
%   ssbal         -Balance ss model using diagonal similarity transformation*.
%
%
% Operations with cells and symbolic matrices.
%   cell2sym      - Cell format to sym format in operator differential. 
%   cellround     - Round to nearest integer in each cell. 
%   normcell      - Normalize cell. 
%   ss2sym        - State Space to Symbolic Transfer Function conversion**.
%   sym2cell      - Sym matrix polynomial format to cell format. 
%   sym2tf        - Symbolic Transfer Function to Numerical Transfer Function**.
%   tf2sym        - Numerical Transfer Function to Symbolic Transfer Function**.
%   det           -Symbolic matrix determinant*.
%   inv           -Symbolic matrix inverse*.
%
%
% Model Order Reduction
%   balancmr       -Balanced model truncation via square root method*. 
%   ncfmr          -Balanced normalized coprime factor model reduction*.
%   schurmr        -Balanced truncation via Schur method*.
%   hankelmr       -Hankel minimum degree approximation without  balancing*.
%
%
% State Feedback Design
%   lyapK         - Lyapunov method design state feedback. 
%   canonK        - Canonical form method design state feedback. 
%   cyclicK       - Cyclic method design state feedback.
%   decopK        - Desacoupling by state feedback.   
%
%
%Graphics User Interface
%   multitool       - MULTI Design Tool
%
% * Matlab Functions
% ** Oskar Vivero oskar.vivero@gmail.com
% Generated from Contents.m_template revision 1.2  $Date: 2009/05/02  24:45:23$
