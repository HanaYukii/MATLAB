%ID: 0516020 ©m¦W¡G§fº¸°a
function P3_0516316(path)
    findjpg = strcat(path, '*.jpg');
    list = dir(findjpg);
    num = numel(list);
    index = 1;
    
    if num > 0
        pic = strcat(path, list(index).name);
        image = imread(pic);
        [row, col, dep] = size(image);
        % resize
        if row>640 || col>480
            image = imresize(image, [640 480], 'nearest');
        end
        imshow(image);
        [row, col, dep] = size(image);
        title(['Picture ', num2str(index), ' of ', num2str(num), ' (', list(index).name, ') ', num2str(row), 'x', num2str(col)]);
    else
        A = zeros(640,480);
        imshow(A);
        title('No Jpgs');
    end
    while 1 
        tt1 = waitforbuttonpress;
        if tt1 ~= 0
            operator = get(gcf, 'CurrentCharacter');
            if operator == '<'
                index = index - 1;
                if index == 0
                    index = num;                   
                end
            elseif operator == '>'
                index = index + 1;
                if index == num + 1
                    index = 1;                   
                end
            elseif operator == 'q'
                close all;
                break;
            end
            pic = strcat(path, list(index).name);
            image = imread(pic);
             [row, col, dep] = size(image);
            if row>640 || col>480
                image = imresize(image, [640 480], 'nearest');
            end
            figure('Position',[500,500,100,100]);
            imshow(image);
            [row, col, dep] = size(image);
            title(['Picture ', num2str(index), ' of ', num2str(num), ' (', list(index).name, ') ', num2str(row), 'x', num2str(col)]);
        % click
        else
            c = get(gca, 'CurrentPoint');
            x = c(1,1); % x col
            y = c(1,2); % y row
            if x <=480 && x >=1 && y<=640 && y>=1
                figure('Position',[1400,500,100,100]);
                imshow(image);
                leng = 50; % initial
                axis([x-leng x+leng y-leng y+leng]);
                while 1
                    tt2 = waitforbuttonpress;
                    if tt2 ~= 0
                        operator2 = get(gcf, 'CurrentCharacter'); 
                        if operator2 == '+'
                            leng = leng * 1.1;
                            if leng>200
                                leng=200;
                            end
                        elseif operator2 == '-'
                            leng = leng * 0.9;
                            if leng<10
                                leng=10;
                            end
                        elseif operator2 == 28
                            x=x-10;
                            if(x<1)
                                x=1;
                            end
                        elseif operator2 == 29
                            x=x+10;
                            if(x>480)
                                x=480;
                            end
                        elseif operator2 == 31
                            y=y+10;
                            if(y>640)
                                y=640;
                            end
                        elseif operator2 == 30
                            y=y-10;
                            if(y<1)
                                y=1;
                            end  
                        elseif operator2 == '>' || operator == '<'
                            close(figure(2));
                            if operator2 == '>'
                                index = index + 1;
                                if index == num + 1
                                    index = 1;
                                end
                            else
                                index = index -1;
                                if index < 1
                                    index = num;
                                end
                            end
                            str = strcat(path, list(index).name);
                            image = imread(str);
                             [row, col, dep] = size(image);
                            if row>640 || col>480
                                image = imresize(image, [640 480], 'nearest');
                            end
                            imshow(image);
                            [row, col, dep] = size(image);
                            title(['Picture ', num2str(index), ' of ', num2str(num), ' (', list(index).name, ') ', num2str(row), 'x', num2str(col)]);
                            break;
                        end
                        imshow(image);
                        axis([x-leng x+leng y-leng y+leng]);
                        axis square;
                    end
                end % while end for tt2
            end
        end
    end %while end for tt1
end