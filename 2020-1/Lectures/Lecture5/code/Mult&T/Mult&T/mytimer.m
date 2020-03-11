function  mytimer(obj, event, op)
h=gcbf;
h=get(h,'children');
hand=findobj(h,'tag','text34');
t1=timerfind;
switch op
    case 1
        set(hand,'string','Click-Right on Panels for Convertions into Models...')
        if ~isempty(t1)
            t1.TimerFcn={'mytimer',2};
            stop(t1)            
            %start(t1)
        end
    case 2
        set(hand,'string','Use the File menu to import the MIMO sys Model...')
        if ~isempty(t1)
            t1.TimerFcn={'mytimer',3};
            stop(t1)
            %start(t1)
         end
    case 3
        set(hand,'string','Button Try Again, Load again the Original Model...')
         if ~isempty(t1)
            t1.TimerFcn={'mytimer',4};
            stop(t1)
            %start(t1)
         end
    case 4
       str={datestr(now,1),...
           datestr(now,14)};
       set(hand,'string',str)
        if ~isempty(t1)
            t1.TimerFcn={'mytimer',5};
            stop(t1)
        end
    case 5 
        set(hand,'string',sprintf('Free Distribution...\n 2009-2014'))
         if ~isempty(t1)
            t1.TimerFcn={'mytimer',6};
             stop(t1)
         end
    case 6
        set(hand,'string',sprintf('ANDES University \n Trial Version'))
        if ~isempty(t1)
            t1.TimerFcn={'mytimer',7};
            stop(t1)
        end
    case 7
        set(hand,'string',sprintf('Design by: \n Ing. Franklin Pineda'))
        if ~isempty(t1)
            t1.TimerFcn={'mytimer',8};
            stop(t1)          
        end        
    case 8
        set(hand,'string',sprintf('Acknowledgement : \n P.h.D. Alain Gauthier Sellier'))
        if ~isempty(t1)
            t1.TimerFcn={'mytimer',1};
            stop(t1)           
        end        
    case 9
        start(t1)        
end    