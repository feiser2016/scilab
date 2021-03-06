//  Scicos
//
//  Copyright (C) INRIA - METALAU Project <scicos@inria.fr>
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
//
// See the file ../license.txt
//

function [x,y,typ]=GENSQR_f(job,arg1,arg2)
    x=[];
    y=[];
    typ=[];
    select job
    case "set" then
        x=arg1;
        graphics=arg1.graphics;
        exprs=graphics.exprs
        model=arg1.model;
        if size(exprs,"*")==2 then
            exprs=exprs(2),
        end //compatibility
        while %t do
            [ok,Amplitude,exprs]=scicos_getvalue(..
            msprintf(_("Set %s block parameters"),"SQUARE WAVE generator"),..
            _("Amplitude"),..
            list("vec",1),exprs)
            if ~ok then
                break,
            end
            graphics.exprs=exprs
            model.dstate=Amplitude
            //next two lines to fix invalid properties in scilab version
            //prior 5.5.0
            model.out2=1;
            model.outtyp=1;

            x.graphics=graphics;
            x.model=model
            break
        end
    case "define" then
        Amplitude=1
        model=scicos_model()
        model.sim="gensqr"
        model.out=1;
        model.out2=1;
        model.outtyp=1;
        model.evtin=1;
        model.dstate=Amplitude
        model.blocktype="d"
        model.dep_ut=[%f %f]

        exprs=string(Amplitude)
        gr_i=[]
        x=standard_define([3 2],model,exprs,gr_i)
    end
endfunction
