#include "gridparam.h"
      integer         Lm, Mm, Lp, Mp, L2d
      parameter (     Lm=L-1    , Mm=M-1   , Lp=L+1,  Mp=M+1  )
      parameter (     L2d=Lp*Mp                               )
!  lcflag tells which color bar to use, 1 - 3 (so far).  If negative
!  then black outlines are drawn over the color contour regions.
      integer         lcflag
      parameter (     lcflag=-5                               )
      real            x_v(0:L+2,0:M+2), y_v(0:L+2,0:M+2)
      common /xxyys/  x_v, y_v
      BIGREAL         xp(L,M), yp(L,M), xr(0:L,0:M), yr(0:L,0:M), &
     &                xu(L,0:M), yu(L,0:M), xv(0:L,M), yv(0:L,M), &
     &                xl, el
      real            xmin, ymin, xmax, ymax
      common /grdpts/ xp, yp, xr, yr, xu, yu, xv, yv, xl, el, &
     &                xmin, ymin, xmax, ymax
      BIGREAL         f(0:L,0:M), h(0:L,0:M)
      common /parm/   f, h
      BIGREAL         pm(0:L,0:M), pn(0:L,0:M), &
     &                dndx(0:L,0:M), dmde(0:L,0:M)
      common /pmpn/   pm, pn, dndx, dmde
      BIGREAL         lat_psi(L,M), lon_psi(L,M), &
     &                lat_rho(0:L,0:M), lon_rho(0:L,0:M), &
     &                lat_u(L,0:M), lon_u(L,0:M), &
     &                lat_v(0:L,M), lon_v(0:L,M)
      common /latlon/ lat_psi, lon_psi, lat_rho, lon_rho, &
     &                lat_u, lon_u, lat_v, lon_v
      BIGREAL         mask_rho(0:L,0:M), mask_u(L,0:M), &
     &                mask_v(0:L,M), mask_psi(L,M)
      common /rmask/  mask_rho, mask_u, mask_v, mask_psi
      BIGREAL         angle(0:L,0:M)
      common /angles/ angle
      integer*2       depthmin, depthmax
      common /hmins/  depthmin, depthmax
      logical         spherical
      common /logic/  spherical