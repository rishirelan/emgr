![emgr Logo](emgr.png) emgr
===========================
Empirical Gramian Framework (Version 3.1)

Empirical gramians can be computed for linear and nonlinear control systems for purposes of model order reduction (MOR), system identification or uncertainty quantification. 
Model reduction using empirical gramians can be applied to the state space, to the parameter space or to both through combined reduction. 
For state reduction the empirical controllability gramian and the empirical observability gramian, for balanced truncation, are available, or alternatively the empirical cross gramian and approximate empirical cross gramian for direct truncation. 
For parameter reduction, parameter identification and sensitivity analysis the empirical sensitivity gramian (controllability of parameters) or the empirical identifiability gramian (observability of parameters) are provided. 
Combined state and parameter reduction is enabled by the empirical joint gramian, which computes controllability and observability of states and parameter concurrently. 
The emgr framework is a compact open source toolbox for (empirical) GRAMIAN-based model reduction and compatible with OCTAVE and MATLAB (and FREEMAT). 

More information at: http://gramian.de

![DOI badge](https://zenodo.org/badge/doi/10.5281/zenodo.17360.png)

Citation
--------

DOI: 10.5281/zenodo.17360 (Version 3.1)

Cite as: C. Himpe. "emgr - Empirical Gramian Framework (Version 3.1)" [Computer Software]. http://gramian.de

BibTeX: @MISC{emgr,author={Himpe, C.},title={{emgr - Empirical Gramian Framework (Version 3.1)}},howpublished={\url{http://gramian.de}},year={2015}}

License
-------

Copyright (c) 2013-2015 Christian Himpe,

All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
   this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
OF SUCH DAMAGE.
