//Library
obj/system/edge
turf
	var
		edge_group=null
		edge_state=""
		edge_corner_state=""
		edge_all_state=""
		edge_corners=FALSE
		edge_north=TRUE
		edge_south=TRUE
		edge_east=TRUE
		edge_west=TRUE
	proc
		internal_edging(var/turf/T,var/turf/OT)
		//	T.overlays=null
			var
				flag_n=FALSE
				flag_s=FALSE
				flag_e=FALSE
				flag_w=FALSE
				fn=FALSE
				fs=FALSE
				fe=FALSE
				fw=FALSE
				flag_ne=FALSE
				flag_nw=FALSE
				flag_se=FALSE
				flag_sw=FALSE
			var/obj/O=new/obj()
			O.loc=T
			step(O,NORTH)
			for(var/turf/TT in range(0,O))
				if(istype(TT,OT))
					flag_n=TRUE
			O.loc=T
			step(O,SOUTH)
			for(var/turf/TT in range(0,O))
				if(istype(TT,OT))
					flag_s=TRUE
			O.loc=T
			step(O,WEST)
			for(var/turf/TT in range(0,O))
				if(istype(TT,OT))
					flag_w=TRUE
			O.loc=T
			step(O,EAST)
			for(var/turf/TT in range(0,O))
				if(istype(TT,OT))
					flag_e=TRUE
			fn=flag_n
			fs=flag_s
			fe=flag_e
			fw=flag_w
			if(OT.edge_corners)
				var/all_test=0
				if(flag_n&&flag_e)
					flag_ne=TRUE
					all_test++
				if(flag_n&&flag_w)
					flag_nw=TRUE
					all_test++
				if(flag_s&&flag_e)
					flag_se=TRUE
					all_test++
				if(flag_s&&flag_w)
					flag_sw=TRUE
					all_test++
				if(all_test>=3)
					var/icon/I=icon(OT.icon,OT.edge_all_state)
					T.overlays+=I
					return
				if(flag_nw&&flag_ne)
					var/icon/I=icon(OT.icon,OT.edge_corner_state,SOUTH)
					T.overlays+=I
					return
				if(flag_sw&&flag_se)
					var/icon/I=icon(OT.icon,OT.edge_corner_state,NORTH)
					T.overlays+=I
					return
				if(flag_sw&&flag_nw)
					var/icon/I=icon(OT.icon,OT.edge_corner_state,EAST)
					T.overlays+=I
					return
				if(flag_se&&flag_ne)
					var/icon/I=icon(OT.icon,OT.edge_corner_state,WEST)
					T.overlays+=I
					return
				if(flag_nw&&OT.edge_east&&OT.edge_south)
					var/icon/I=icon(OT.icon,OT.edge_corner_state,SOUTHEAST)
					T.overlays+=I
					flag_n=FALSE
					flag_w=FALSE
				if(flag_ne&&OT.edge_west&&OT.edge_south)
					var/icon/I=icon(OT.icon,OT.edge_corner_state,SOUTHWEST)
					T.overlays+=I
					flag_n=FALSE
					flag_e=FALSE
				if(flag_sw&&OT.edge_east&&OT.edge_north)
					var/icon/I=icon(OT.icon,OT.edge_corner_state,NORTHEAST)
					T.overlays+=I
					flag_s=FALSE
					flag_w=FALSE
				if(flag_se&&OT.edge_west&&OT.edge_north)
					var/icon/I=icon(OT.icon,OT.edge_corner_state,NORTHWEST)
					T.overlays+=I
					flag_s=FALSE
					flag_e=FALSE
			if(flag_n&&OT.edge_south)
				var/icon/I=icon(OT.icon,OT.edge_state,SOUTH)
				T.overlays+=I
			if(flag_s&&OT.edge_north)
				var/icon/I=icon(OT.icon,OT.edge_state,NORTH)
				T.overlays+=I
			if(flag_w&&OT.edge_east)
				var/icon/I=icon(OT.icon,OT.edge_state,EAST)
				T.overlays+=I
			if(flag_e&&OT.edge_west)
				var/icon/I=icon(OT.icon,OT.edge_state,WEST)
				T.overlays+=I
			if(OT.edge_corners)
				O.loc=T
				step(O,SOUTHWEST)
				for(var/turf/TT in range(0,O))
					if(istype(TT,OT)&&!flag_sw&&!fs&&!fw&&OT.edge_east&&OT.edge_north)
						var/icon/I=icon(OT.icon,OT.edge_state,NORTHEAST)
						T.overlays+=I
				O.loc=T
				step(O,SOUTHEAST)
				for(var/turf/TT in range(0,O))
					if(istype(TT,OT)&&!flag_se&&!fs&&!fe&&OT.edge_west&&OT.edge_north)
						var/icon/I=icon(OT.icon,OT.edge_state,NORTHWEST)
						T.overlays+=I
				O.loc=T
				step(O,NORTHWEST)
				for(var/turf/TT in range(0,O))
					if(istype(TT,OT)&&!flag_nw&&!fn&&!fw&&OT.edge_east&&OT.edge_south)
						var/icon/I=icon(OT.icon,OT.edge_state,SOUTHEAST)
						T.overlays+=I
				O.loc=T
				step(O,NORTHEAST)
				for(var/turf/TT in range(0,O))
					if(istype(TT,OT)&&!flag_ne&&!fn&&!fe&&OT.edge_west&&OT.edge_south)
						var/icon/I=icon(OT.icon,OT.edge_state,SOUTHWEST)
						T.overlays+=I
		create_edging(var/turf/T)
			var/obj/O=new/obj()
			O.step_size=32
			O.density=0
			O.loc=T
			step(O,NORTH)
			for(var/turf/TT in range(0,O))
				if(!istype(T,TT)&&T.name!=TT.name&&edge_north==TRUE&&T.layer>=TT.layer)
					if(T.edge_group!=null&&T.edge_group==TT.edge_group)
					else
						TT.internal_edging(TT,T)
			O.loc=T
			step(O,SOUTH)
			for(var/turf/TT in range(0,O))
				if(!istype(T,TT)&&T.name!=TT.name&&edge_south==TRUE&&T.layer>=TT.layer)
					if(T.edge_group!=null&&T.edge_group==TT.edge_group)
					else
						TT.internal_edging(TT,T)
			O.loc=T
			step(O,EAST)
			for(var/turf/TT in range(0,O))
				if(!istype(T,TT)&&T.name!=TT.name&&edge_east==TRUE&&T.layer>=TT.layer)
					if(T.edge_group!=null&&T.edge_group==TT.edge_group)
					else
						TT.internal_edging(TT,T)
			O.loc=T
			step(O,WEST)
			for(var/turf/TT in range(0,O))
				if(!istype(T,TT)&&T.name!=TT.name&&edge_west==TRUE&&T.layer>=TT.layer)
					if(T.edge_group!=null&&T.edge_group==TT.edge_group)
					else
						TT.internal_edging(TT,T)
			O.loc=T
			step(O,NORTHEAST)
			for(var/turf/TT in range(0,O))
				if(!istype(T,TT)&&T.name!=TT.name&&edge_north==TRUE&&T.layer>=TT.layer)
					if(T.edge_group!=null&&T.edge_group==TT.edge_group)
					else
						TT.internal_edging(TT,T)
			O.loc=T
			step(O,SOUTHWEST)
			for(var/turf/TT in range(0,O))
				if(!istype(T,TT)&&T.name!=TT.name&&edge_south==TRUE&&T.layer>=TT.layer)
					if(T.edge_group!=null&&T.edge_group==TT.edge_group)
					else
						TT.internal_edging(TT,T)
			O.loc=T
			step(O,SOUTHEAST)
			for(var/turf/TT in range(0,O))
				if(!istype(T,TT)&&T.name!=TT.name&&edge_east==TRUE&&T.layer>=TT.layer)
					if(T.edge_group!=null&&T.edge_group==TT.edge_group)
					else
						TT.internal_edging(TT,T)
			O.loc=T
			step(O,NORTHWEST)
			for(var/turf/TT in range(0,O))
				if(!istype(T,TT)&&T.name!=TT.name&&edge_west==TRUE&&T.layer>=TT.layer)
					if(T.edge_group!=null&&T.edge_group==TT.edge_group)
					else
						TT.internal_edging(TT,T)