function creditos_1(action)
h=get(gcbf,'children');
axes1=findobj(h,'tag','Axes1');
boton_creditos=findobj(h,'tag','creditos');
text1=findobj(axes1,'tag','text1');
text2=findobj(axes1,'tag','text2');
text3=findobj(axes1,'tag','text3');
switch action
    case 'credit'
        value=get(boton_creditos,'value');
        if value==1
            set(text1,'string','P.h.D. Alain Gauthier Sellier');
            set(text2,'string','M.Sc. Alonso de Jesus Chica');
            set(text3,'string','My parents...');
            set(boton_creditos,'string','Acknowledgements')
        elseif value==0
            set(text1,'string','Design and Construction :');
            set(text2,'string','Ing. Franklin Pineda Torres.');
            set(text3,'string','fe.pineda92@uniandes.edu.co.');            
            set(boton_creditos,'string','Credits')
        end
    case 'close_acerca'
        close('force','About Mult&T')
end
