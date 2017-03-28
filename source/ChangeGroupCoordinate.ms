rollout ChangeGroupCoordinate "change pivot position" width:216 height:320
(
	
	button 'btnX_P' "X正方向" pos:[89,7] width:46 height:20 align:#left
	button 'btnY_P' "Y正方向" pos:[23,42] width:42 height:15 align:#left
	button 'btnZ_E' "Z负方向" pos:[158,40] width:46 height:20 align:#left
	button 'btnY_E' "Y负方向" pos:[159,94] width:46 height:20 align:#left
	button 'btnX_E' "X负方向" pos:[89,134] width:46 height:20 align:#left
	button 'btnZ_P' "Z正方向" pos:[22,94] width:46 height:20 align:#left
	button 'btn_center' "本地中心" pos:[89,65] width:47 height:20 align:#left
	editText 'edt5' "" pos:[81,246] width:55 height:20 align:#left
	button 'PivotMoveOffset' "StartMove" pos:[77,280] width:63 height:14 align:#left
	editText 'edt6' "" pos:[14,246] width:55 height:20 align:#left
	editText 'edt7' "" pos:[153,246] width:55 height:20 align:#left
	label 'lbl2' "X" pos:[4,249] width:8 height:16 align:#left
	label 'lbl3' "Z" pos:[144,247] width:8 height:16 align:#left
	label 'lbl4' "Y" pos:[75,249] width:8 height:16 align:#left
	label 'lbl5' "中心移动" pos:[14,225] width:92 height:14 align:#left
	label 'lbl6' "面数" pos:[10,168] width:83 height:14 align:#left
	label 'lbl7' "模型尺寸" pos:[10,189] width:51 height:14 align:#left
	label 'lbl8' "0" pos:[101,168] width:70 height:14 align:#left
	label 'lbl9' "0" pos:[65,189] width:145 height:14 align:#left
	--button 'btn9' "世界中心" pos:[89,87] width:48 height:20 align:#left


	local X_P = 1;
	local X_E = 2;
	local Y_P = 3;
	local Y_E = 4;
	local Z_P = 5;
	local Z_E = 6;
	local Z_CenterLocal = 7;
	local Z_CenterWorld = 8;
	local selectgroup
	
	
	--寻找组
fn FindGroupHead obj = 
(
	if ((isGroupHead obj) AND (not (isGroupMember obj))) then
		(	print (obj.name as string)
			return obj
		) 
	
	return undefined
)
--移动
fn MoveGroupToPosition type =
(
	if selection.count != 0 then
	(
		local flag =true
		for obj in selection do 
		(	
			--faces_lbl.text = PolygonInfo[1] As String
			local res = FindGroupHead obj
			if res != undefined then
			(
				if flag == true then
				(
					toolMode.pivotCenter() 
					local x_offset = (obj.max.x - obj.min.x)/2
					local y_offset = (obj.max.y - obj.min.y)/2
					local z_offset = (obj.max.z - obj.min.z)/2
					format "%:\t%\n" "pivot" type
					format "%:\t%\n" "res" res.transform[4]
					case type of
					(	
					--X positive
					1 :obj.pivot = [obj.center.x + x_offset,obj.center.y,obj.center.z] 
					--X Negative
					2 : obj.pivot = [obj.center.x - x_offset,obj.center.y,obj.center.z] 
					--Y positive
					3 : obj.pivot = [obj.center.x ,obj.center.y + y_offset,obj.center.z] 
					--Y Negative
					4 : obj.pivot = [obj.center.x ,obj.center.y - y_offset,obj.center.z] 
					--Z positive
					5 : obj.pivot = [obj.center.x ,obj.center.y ,obj.center.z + z_offset] 
					--Z Negative
					6 : obj.pivot = [obj.center.x ,obj.center.y ,obj.center.z - z_offset] 
					--Z CenterLocal
					7 : obj.pivot = [obj.center.x ,obj.center.y ,obj.center.z]
					--Z CenterWorld
					8 : obj.position  = [0 ,0 ,0]
						
					default:print (mmmmmmmm as string)
					)
					obj.position  = [0 ,0 ,0]	
					--输出 Node 支点位置 
					format "%:\t%\n" "pivot" obj.pivot
					
				)	
				flag = false
				
			)
			else
			(
				--print ("This is not a group")
			)			
		)

	)
	else
	(
		print ("Please select a group ")
	)	
)
	
	on ChangeGroupCoordinate open  do
	(
		if selection.count != 0 then
		(	
			local flag =true			
			local face_num = 0
			for obj in selection do
			(
				-- 打印几何体的名称	
				local PolygonInfo = getPolygonCount obj
				face_num = face_num + PolygonInfo[1]
				
				selectgroup = FindGroupHead obj
				if selectgroup != undefined then
				(
					lbl9.text = (selectgroup.max - selectgroup.min) As String
				)	
			)
			lbl8.text = face_num As String
		)
		else
		(
			print ("Please select a group ")
		)
		--toolMode.pivotCenter() 
		--toolMode.selectionCenter() 
		--toolMode.transformCenter()		
	)		
	on btnX_P pressed  do
		MoveGroupToPosition X_P
	on btnX_E pressed  do
		MoveGroupToPosition X_E
	on btnY_P pressed  do
		MoveGroupToPosition Y_P
	on btnY_E pressed  do
		MoveGroupToPosition Y_E
	on btnZ_P pressed  do
		MoveGroupToPosition Z_P
	on btnZ_E pressed  do
		MoveGroupToPosition Z_E
	on btn_center pressed  do
		MoveGroupToPosition Z_CenterLocal
	--on btn9 pressed  do
		--MoveGroupToPosition Z_CenterWorld
	on PivotMoveOffset pressed  do
	(	
		local offset = #(edt6.text As Integer,edt5.text As Integer,edt7.text As Integer)
		
		if selection.count != 0 then
		(
			local flag =true
			for obj in selection do 
			(	
				if flag == true then
				(
					local res = FindGroupHead obj
					format "%:\t%\n" "pivot" obj.name
					if res != undefined then
					(
						res.pivot = [res.pivot.x + offset[1],res.pivot.y+ offset[2],res.pivot.z+ offset[3]] 
						format "%:\t%\n" "pivot" res.pivot
						flag = false
					)
				)
				
			)	
		)			
	)
)
 
 
