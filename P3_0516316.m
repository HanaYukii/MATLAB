%ID: 0516316 姓名：呂爾軒
function P3_0516316(path)
    pathjpg=strcat(path,'*.jpg');
    pictures=dir(pathjpg);
    cnt=numel(pictures);
    index=1;
    if cnt>0
        now=strcat(path, pictures(index).name);
        image=imread(now);
        [row,col,h]=size(image);
        h;
        if row>=640||col>=480
            image=imresize(image,[640 480],'nearest');
            normal=image;
        else
            put_row = floor((640-row)/2);
            put_col = floor((480-col)/2);
            new_image = padarray(image, [put_row put_col], 0);
            [row, col, h] = size(new_image);
            h;
            normal = imresize(new_image, [640 480], 'nearest');
        end
        imshow(normal);
        [row,col,h]=size(normal);
        h;
        title(['Picture ', num2str(index), ' of ', num2str(cnt), ' (', pictures(index).name, ') ', num2str(row), 'x', num2str(col)]);
    else
        A = zeros(640,480);
        imshow(A);
        title('No jpgs');
    end
    
    while 1
        t=waitforbuttonpress;
        if t>0
            op=get(gcf, 'CurrentCharacter');
            if op=='<'
                index=index-1;
                if index==0
                    index=cnt;
                end
            elseif op=='>'
                index=index+1;
                if index==cnt+1
                    index=1;
                end
            elseif op=='q'
                close all;
                break;
            end
            now = strcat(path, pictures(index).name);
            image = imread(now);
            [row, col, h] = size(image);
            h;
            if row>=640 || col>=480
                image = imresize(image, [640 480], 'nearest');
            end
            normal = image;
            imshow(normal);
            [row, col, h] = size(image);
            h;
            title(['Picture ', num2str(index), ' of ', num2str(cnt), ' (', pictures(index).name, ') ', num2str(row), 'x', num2str(col)]);
        else
            c1 = get(gca, 'CurrentPoint');
            x = c1(1,1); % x col
            y = c1(1,2); % y row
            if x <=480 && x >=1 && y<=640 && y>=1
                radius = 50; 
                figure(1);
                imshow(normal);
                top=min(y+radius,480);
                bot=max(1,y-radius);
                left=max(1,x-radius);
                right=min(640,x+radius);
                line([left right], [top top], 'color', 'k', 'LineWidth', 3);
                line([left right], [bot bot], 'color', 'k', 'LineWidth', 3);
                line([left left], [bot top], 'color', 'k', 'LineWidth', 3);
                line([right right], [bot top], 'color', 'k', 'LineWidth', 3);
                figure('Position',[1400,500,100,100]);
                imshow(image);
                am = ((2*radius)*(2*radius)) / (row*col) *100;
                title(['Picture ', num2str(index), ' of ', num2str(cnt), ' (', pictures(index).name, ') ', num2str(row), 'x', num2str(col), ' @ ', num2str(am), ' %']);
                axis([x-radius x+radius y-radius y+radius]);
                while 1
                    tt2 = waitforbuttonpress;
                    if tt2 ~= 0
                        operator2 = get(gcf, 'CurrentCharacter'); 
                        if operator2 == '+'
                            radius = radius * 0.91;
                            if radius < 10
                                radius = 10;
                            end
                        elseif operator2 == '-'
                            radius = radius * 1.09;
                            if radius > 150
                                radius = 150;
                            end
                        elseif operator2 == '>' || operator2 == '<' || operator2 == 'q'
                            close(figure(2));
                            if operator2 == '>'
                                index = index + 1;
                                if index == cnt + 1
                                    index = 1;
                                end
                            elseif operator2 == '<'
                                index = index - 1;
                                if index < 1
                                    index = cnt;
                                end
                            end
                            str = strcat(path, pictures(index).name);
                            image = imread(str);
                            [row, col, h] = size(image);
                            h;
                            if row>640 || col>480
                                image = imresize(image, [640 480], 'nearest');
                                normal = image;
                            else
                                normal = image;
                            end
                            imshow(normal);
                            [row, col, h] = size(normal);
                            h;
                            title(['Picture ', num2str(index), ' of ', num2str(cnt), ' (', pictures(index).name, ') ', num2str(row), 'x', num2str(col)]);
                            break;
                        %arrow----
                        elseif operator2 == 28 
                            x = x - 10;
                            if x < 1
                                x = 1;
                            end
                        elseif operator2 == 29 
                            x = x + 10;
                            if x > 480
                                x = 480;
                            end
                        elseif operator2 == 31 
                            y = y + 10;
                            if y > 640
                                y = 640;
                            end
                        elseif operator2 == 30 
                            y = y - 10;
                            if y < 1
                                y = 1;
                            end
                        end
                        figure(1);
                        imshow(normal);
                        top=min(y+radius,480);
                        bot=max(1,y-radius);
                        left=max(1,x-radius);
                        right=min(640,x+radius);
                        line([left right], [top top], 'color', 'k', 'LineWidth', 3);
                        line([left right], [bot bot], 'color', 'k', 'LineWidth', 3);
                        line([left left], [bot top], 'color', 'k', 'LineWidth', 3);
                        line([right right], [bot top], 'color', 'k', 'LineWidth', 3);
                        figure(2);
                        am = ((2*radius)*(2*radius)) / (row*col) * 100;
                        imshow(image);
                        title(['Picture ', num2str(index), ' of ', num2str(cnt), ' (', pictures(index).name, ') ', num2str(row), 'x', num2str(col), ' @ ', num2str(am), ' %']);
                        axis([x-radius x+radius y-radius y+radius]);
                    else
                        c2 = get(gca, 'CurrentPoint');
                        x2 = c2(1, 1);
                        y2 = c2(1, 2);
                        if x2 < x-radius || x2 > x+radius || y2 < y-radius || y2 > y+radius
                            close (figure(2));
                            figure(1);
                            imshow(normal);
                            [row, col, h] = size(normal);
                            h;
                            title(['Picture ', num2str(index), ' of ', num2str(cnt), ' (', pictures(index).name, ') ', num2str(row), 'x', num2str(col)]);
                            break;
                        end
                    end % if tt2
                end % while end for tt2
            end
        end
    end %while end for tt1
end
