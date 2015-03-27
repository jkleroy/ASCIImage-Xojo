#tag Window
Begin Window Window1
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   220741631
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "Untitled"
   Visible         =   True
   Width           =   600
   Begin Canvas Canvas1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   360
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   20
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   560
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  
		End Sub
	#tag EndEvent


#tag EndWindowCode

#tag Events Canvas1
	#tag Event
		Sub Open()
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  Dim gg As Graphics
		  
		  #if TargetWin32
		    Dim Buffer As Picture = new Picture(g.Width, g.Height, 32)
		    gg = Buffer.Graphics
		  #else
		    gg = g
		  #endif
		  
		  
		  gg.AntiAlias = true
		  
		  
		  
		  
		  Dim rep() As String
		  
		  rep.Append "· · · · · · · · · · · ·"
		  rep.Append "· · · · · · · · · · · ·"
		  rep.Append "· · · · · · · · · · · ·"
		  rep.Append "· · · · · · 1 · · · · ·"
		  rep.Append "· · · · · · o o · · · ·"
		  rep.Append "· · · 7 o o 8 o 2 · · ·"
		  rep.Append "· · · 6 o o 5 o 3 · · ·"
		  rep.Append "· · · · · · o o · · · ·"
		  rep.Append "· · · · · · 4 · · · · ·"
		  rep.Append "· · · · · · · · · · · ·"
		  rep.Append "· · · · · · · · · · · ·"
		  rep.Append "· · · · · · · · · · · ·"
		  
		  gg.DrawASCIIRepresentation(rep, 0, 0, 1)
		  
		  gg.DrawASCIIRepresentation(rep, 30, 0, 2)
		  
		  gg.DrawASCIIRepresentation(rep, 80, 0, 3)
		  
		  
		  
		  Redim rep(-1)
		  
		  rep.Append "1 # # # # # # # # # # 1"
		  rep.Append "4 . . . . . . . . . . 2"
		  rep.Append "# . 5 # # # # # # 5 . #"
		  rep.Append "# . . . . . . . . . . #"
		  rep.Append "# . 6 # # # # # # 6 . #"
		  rep.Append "# . . . . . . . . . . #"
		  rep.Append "# . 7 # # # # # # 7 . #"
		  rep.Append "# . . . . . . . . . . #"
		  rep.Append "# . . . . . . . . . . #"
		  rep.Append "# . . . 8 # # 8 . . . #"
		  rep.Append "4 . . . . . . . . . . 2"
		  rep.Append "3 # # # # # # # # # # 3"
		  
		  gg.DrawASCIIRepresentation(rep, 0, 50, 1)
		  
		  gg.DrawASCIIRepresentation(rep, 30, 50, 2)
		  
		  gg.DrawASCIIRepresentation(rep, 80, 50, 3)
		  
		  
		  
		  Redim rep(-1)
		  
		  rep.Append "· · · · · · · · · · · ·"
		  rep.Append "· · · 1 2 · · · · · · ·"
		  rep.Append "· · · A o o · · · · · ·"
		  rep.Append "· · · · o o o · · · · ·"
		  rep.Append "· · · · · o o o · · · ·"
		  rep.Append "· · · · · · 9 o 3 · · ·"
		  rep.Append "· · · · · · 8 o 4 · · ·"
		  rep.Append "· · · · · o o o · · · ·"
		  rep.Append "· · · · o o o · · · · ·"
		  rep.Append "· · · 7 o o · · · · · ·"
		  rep.Append "· · · 6 5 · · · · · · ·"
		  rep.Append "· · · · · · · · · · · ·"
		  
		  gg.DrawASCIIRepresentation(rep, 0, 100, 1)
		  
		  gg.DrawASCIIRepresentation(rep, 30, 100, 2)
		  
		  gg.DrawASCIIRepresentation(rep, 80, 100, 3)
		  
		  Redim rep(-1)
		  
		  rep.Append "..2.......4."
		  rep.Append "......1....."
		  rep.Append "............"
		  rep.Append "............"
		  rep.Append "............"
		  rep.Append "..1.......1."
		  rep.Append "............"
		  rep.Append "............"
		  rep.Append "............"
		  rep.Append "......1....."
		  rep.Append "............"
		  
		  gg.DrawASCIIRepresentation(rep, 0, 150, 1)
		  
		  gg.DrawASCIIRepresentation(rep, 30, 150, 2)
		  
		  gg.DrawASCIIRepresentation(rep, 80, 150, 3)
		  
		  Redim rep(-1)
		  
		  g.AntiAlias = True
		  rep.Append "....3............."
		  rep.Append ".........7........"
		  rep.Append ".................."
		  rep.Append "...13..1.........."
		  rep.Append "5..5...........B.."
		  rep.Append ".....2...7....2..."
		  rep.Append ".................."
		  rep.Append "...1...1.........."
		  rep.Append "...........B.9...."
		  rep.Append ".8...8............"
		  rep.Append ".................."
		  rep.Append "........C........."
		  rep.Append ".................9"
		  rep.Append "........A........."
		  rep.Append ".....2........2..."
		  rep.Append "....C............."
		  rep.Append ".................."
		  rep.Append "............A....."
		  
		  gg.DrawASCIIRepresentation(rep, 0, 200, 1)
		  
		  gg.DrawASCIIRepresentation(rep, 30, 200, 2)
		  
		  gg.DrawASCIIRepresentation(rep, 80, 200, 3)
		  
		  #if TargetWin32
		    
		    g.DrawPicture(Buffer, 0, 0)
		  #endif
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Appearance"
		InitialValue="&hFFFFFF"
		Type="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Appearance"
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="CloseButton"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Appearance"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"10 - Drawer Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackColor"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Position"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="Appearance"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Position"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Position"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Appearance"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Position"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Position"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Appearance"
		InitialValue="Untitled"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Position"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
