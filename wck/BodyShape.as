﻿package wck {		import Box2DAS.*;	import Box2DAS.Collision.*;	import Box2DAS.Collision.Shapes.*;	import Box2DAS.Common.*;	import Box2DAS.Dynamics.*;	import Box2DAS.Dynamics.Contacts.*;	import Box2DAS.Dynamics.Joints.*;	import cmodule.Box2D.*;	import wck.*;	import misc.*;	import flash.utils.*;	import flash.events.*;	import flash.display.*;	import flash.text.*;	import flash.geom.*;	import flash.ui.*;		/**	 * Wraps both b2Body and b2Shape and provides inspectable properties that can be edited in flash. Some properties of BodyShapes:	 	 * 1. If a BodyShape has another BodyShape as an	 * parent/ancestor, it will act as a shape within that body. It it only has a World as an ancestor, it will act as a Body. BodyShapes can be moved	 * around the display hierarchy and their role will shift depending on their ancestery. 	 *	 * 2. Many shapes can be defined per BodyShape to create complex shapes that are a single symbol in Flash. See defineShapes().	 *	 * 3. The transformation of the BodyShape relative to the world (position, rotation, scale & skew), will be applied to the 	 * shape definitions before they are sent to Box2d - the visual representation of the shape will always match the physical simulation (with limits).	 * A BodyShape can have many other DisplayObjects (with their own transforms) between it and the world.	 *	 */	public class BodyShape extends ScrollerChild {				/// The Joint-extending class to use for mouse dragging. This can be set to provide a visual, custom mouse joint.		public static var dragJointClass:Class = Joint;				/// Base strength of the drag mouse joint.		public static var dragJointStrength:Number = 100;				/// Added to the strength of the mouse joint - multiplied by the mass of the body being dragged.		public static var dragJointMassFactor:Number = 200;						/// See the Box2d documentation of b2Body for explanation of these variables:						/// linearVelocity				[Inspectable(defaultValue=0.0)]		public function set linearVelocityX(v:Number):void {			if(b2body) {				b2body.m_linearVelocity.x = v;			}			else {				_linearVelocity.x = v;			}		}				public function get linearVelocityX():Number {			if(b2body) {				return b2body.m_linearVelocity.x;			}			else {				return _linearVelocity.x;			}				}		[Inspectable(defaultValue=0.0)]		public function set linearVelocityY(v:Number):void {			if(b2body) {				b2body.m_linearVelocity.y = v;			}			else {				_linearVelocity.y = v;			}		}				public function get linearVelocityY():Number {			if(b2body) {				return b2body.m_linearVelocity.y;			}			else {				return _linearVelocity.y;			}				}				public function set linearVelocity(v:V2):void {			if(b2body) {				b2body.SetLinearVelocity(v);			}			else {				_linearVelocity.copy(v);			}		}				public function get linearVelocity():V2 {			if(b2body) {				return b2body.GetLinearVelocity();			}			else {				return _linearVelocity;			}		}				public var _linearVelocity:V2 = new V2(0, 0);						/// angularVelocity				[Inspectable(defaultValue=0.0)]				public function set angularVelocity(v:Number):void {			if(b2body) {				b2body.SetAngularVelocity(v);			}			else {				_angularVelocity = v;			}		}				public function get angularVelocity():Number {			if(b2body) {				return b2body.GetAngularVelocity();			}			else {				return _angularVelocity;			}		}				public var _angularVelocity:Number = 0.0;						/// linearDamping				[Inspectable(defaultValue=0.0)]		public function set linearDamping(v:Number) {			if(b2body) {				b2body.SetLinearDamping(v);			}			else {				_linearDamping = v;			}		}				public function get linearDamping():Number {			if(b2body) {				return b2body.GetLinearDamping();			}			else {				return _linearDamping;			}		}				public var _linearDamping:Number = 0.0;						/// angularDamping				[Inspectable(defaultValue=0.0)]		public function set angularDamping(v:Number) {			if(b2body) {				b2body.SetAngularDamping(v);			}			else {				_angularDamping = v;			}		}				public function get angularDamping():Number {			if(b2body) {				return b2body.GetAngularDamping();			}			else {				return _angularDamping;			}		}						public var _angularDamping:Number = 0.0;						/// autoSleep				[Inspectable(defaultValue=true)]		public function set autoSleep(v:Boolean) {			if(b2body) {				b2body.SetSleepingAllowed(v);			}			else {				_autoSleep = v;			}		}				public function get autoSleep():Boolean {			if(b2body) {				return b2body.IsSleepingAllowed();			}			else {				return _autoSleep;			}		}				public var _autoSleep:Boolean = true;						/// awake				[Inspectable(defaultValue=true)]		public function set awake(v:Boolean) {			if(b2body) {				b2body.SetAwake(v);			}			else {				_awake = v;			}		}				public function get awake():Boolean {			if(b2body) {				return b2body.IsAwake();			}			else {				return _awake;			}		}				public var _awake:Boolean = true;						/// fixedRotation				[Inspectable(defaultValue=false)]		public function set fixedRotation(v:Boolean) {			if(b2body) {				b2body.SetFixedRotation(v);			}			else {				_fixedRotation = v;			}		}				public function get fixedRotation():Boolean {			if(b2body) {				return b2body.IsFixedRotation();			}			else {				return _fixedRotation;			}		}						public var _fixedRotation:Boolean = false;						/// bullet				[Inspectable(defaultValue=false)]		public function set bullet(v:Boolean) {			if(b2body) {				b2body.SetBullet(v);			}			else {				_bullet = v;			}		}				public function get bullet():Boolean {			if(b2body) {				return b2body.IsBullet();			}			else {				return _bullet;			}		}				public var _bullet:Boolean = false;						/// type				[Inspectable(defaultValue="Dynamic",enumeration="Static,Kinematic,Dynamic")]		public function set type(v:String) {			if(b2body) {				b2body.SetType({Static: b2Body.b2_staticBody, Kinematic: b2Body.b2_kinematicBody, Dynamic: b2Body.b2_dynamicBody}[v]);			}			else {				_type = v;			}		}				public function get type():String {			if(b2body) {				switch(b2body.GetType()) {					case b2Body.b2_staticBody: return 'Static';					case b2Body.b2_dynamicBody: return 'Dynamic';				}				return 'Kinematic';			}			else {				return _type;			}		}				public var _type:String = 'Dynamic';						/// active				[Inspectable(defaultValue=true)]		public function set active(v:Boolean) {			if(b2body) {				b2body.SetActive(v);			}			else {				_active = v;			}		}				public function get active():Boolean {			if(b2body) {				return b2body.IsActive();			}			else {				return _active;			}		}				public var _active:Boolean = true;				[Inspectable(defaultValue=1)]		public function set inertiaScale(v:Number) {			if(b2body) {				b2body.SetInertiaScale(v);			}			else {				_inertiaScale = v;			}		}				public function get inertiaScale():Number {			if(b2body) {				return b2body.GetInertiaScale();			}			else {				return _inertiaScale;			}		}				public var _inertiaScale:Number = 1;						/// See the Box2d documentation of b2Fixture for explanations of these variables:						/// friction				[Inspectable(defaultValue=0.2)]		public function set friction(v:Number) {			if(b2fixtures) {				for(var i:int = 0; i < b2fixtures.length; ++i) {					b2fixtures[i].SetFriction(v);				}			}			else {				_friction = v;			}		}				public function get friction():Number {			if(b2fixtures && b2fixtures.length > 0) {				return b2fixtures[0].GetFriction();			}			else {				return _friction;			}		}				public var _friction:Number = 0.2;						/// restitution				[Inspectable(defaultValue=0.0)]		public function set restitution(v:Number) {			if(b2fixtures) {				for(var i:int = 0; i < b2fixtures.length; ++i) {					b2fixtures[i].SetRestitution(v);				}			}			else {				_restitution = v;			}		}				public function get restitution():Number {			if(b2fixtures && b2fixtures.length > 0) {				return b2fixtures[0].GetRestitution();			}			else {				return _restitution;			}		}				public var _restitution:Number = 0.0;						/// density				[Inspectable(defaultValue=1.0)]		public function set density(v:Number) {			if(b2fixtures) {				for(var i:int = 0; i < b2fixtures.length; ++i) {					b2fixtures[i].SetDensity(v);				}			}			else {				_density = v;			}		}				public function get density():Number {			if(b2fixtures && b2fixtures.length > 0) {				return b2fixtures[0].GetDensity();			}			else {				return _density;			}		}				public var _density:Number = 1.0;						/// categoryBits				[Inspectable(defaultValue='0x0001',type='String')]		public function set categoryBits(v:*):void {			v = ((v is String) ? parseInt(v) : v);			if(b2fixtures && b2fixtures.length > 0) {				for(var i:int = 0; i < b2fixtures.length; ++i) {					b2fixtures[i].m_filter.categoryBits = v;					b2fixtures[i].Refilter();				}			}			else {				_categoryBits = v;			}		}				public function get categoryBits():int {			if(b2fixtures && b2fixtures.length > 0) {				return b2fixtures[0].m_filter.categoryBits;			}			else {				return _categoryBits;			}		}				public var _categoryBits:int = 0x0001;						/// maskBits 				[Inspectable(defaultValue='0xFFFF',type='String')]		public function set maskBits(v:*):void {			v = ((v is String) ? parseInt(v) : v);			if(b2fixtures && b2fixtures.length > 0) {				for(var i:int = 0; i < b2fixtures.length; ++i) {					b2fixtures[i].m_filter.maskBits = v;					b2fixtures[i].Refilter();				}			}			else {				_maskBits = v;			}		}				public function get maskBits():int {			if(b2fixtures && b2fixtures.length > 0) {				return b2fixtures[0].m_filter.maskBits;			}			else {				return _maskBits;			}		}				public var _maskBits:int = 0xFFFF;						// groupIndex				[Inspectable(defaultValue=0)]		public function set groupIndex(v:int):void {			_groupIndex = v;		}				public function get groupIndex():int {			return _groupIndex;		}				public var _groupIndex:int = 0;						/// isSensor				[Inspectable(defaultValue=false)]		public function set isSensor(v:Boolean) {			if(b2fixtures) {				for(var i:int = 0; i < b2fixtures.length; ++i) {					b2fixtures[i].SetSensor(v);				}			}			else {				_isSensor = v;			}		}				public function get isSensor():Boolean {			if(b2fixtures && b2fixtures.length > 0) {				return b2fixtures[0].IsSensor();			}			else {				return _isSensor;			}		}				public var _isSensor:Boolean = false;						/// The following variables indicate if this body / shape needs contact events to be reported.						/// Dispatch "onContactBegin" events?				[Inspectable(defaultValue=false)]		public function set reportBeginContact(v:Boolean) {			if(b2fixtures) {				for(var i:int = 0; i < b2fixtures.length; ++i) {					b2fixtures[i].m_reportBeginContact = v;				}			}			else {				_reportBeginContact = v;			}		}				public function get reportBeginContact():Boolean {			if(b2fixtures && b2fixtures.length > 0) {				return b2fixtures[0].m_reportBeginContact;			}			else {				return _reportBeginContact;			}		}				public var _reportBeginContact:Boolean = false;						/// Dispatch "onContactEnd" events?				[Inspectable(defaultValue=false)]		public function set reportEndContact(v:Boolean) {			if(b2fixtures) {				for(var i:int = 0; i < b2fixtures.length; ++i) {					b2fixtures[i].m_reportEndContact = v;				}			}			else {				_reportEndContact = v;			}		}				public function get reportEndContact():Boolean {			if(b2fixtures && b2fixtures.length > 0) {				return b2fixtures[0].m_reportEndContact;			}			else {				return _reportEndContact;			}		}				public var _reportEndContact:Boolean = false;						/// Dispatch "onPreSolve" events?				[Inspectable(defaultValue=false)]		public function set reportPreSolve(v:Boolean) {			if(b2fixtures) {				for(var i:int = 0; i < b2fixtures.length; ++i) {					b2fixtures[i].m_reportPreSolve = v;				}			}			else {				_reportPreSolve = v;			}		}				public function get reportPreSolve():Boolean {			if(b2fixtures && b2fixtures.length > 0) {				return b2fixtures[0].m_reportPreSolve;			}			else {				return _reportPreSolve;			}		}				public var _reportPreSolve:Boolean = false;						/// Dispatch "onPostSolve" events? 				[Inspectable(defaultValue=false)]		public function set reportPostSolve(v:Boolean) {			if(b2fixtures) {				for(var i:int = 0; i < b2fixtures.length; ++i) {					b2fixtures[i].m_reportPostSolve = v;				}			}			else {				_reportPostSolve = v;			}		}				public function get reportPostSolve():Boolean {			if(b2fixtures && b2fixtures.length > 0) {				return b2fixtures[0].m_reportPostSolve;			}			else {				return _reportPostSolve;			}		}				public var _reportPostSolve:Boolean = false;				/// conveyorBeltSpeed				[Inspectable(defaultValue=0)]		public function set conveyorBeltSpeed(v:Number) {			if(b2fixtures) {				for(var i:int = 0; i < b2fixtures.length; ++i) {					b2fixtures[i].m_conveyorBeltSpeed = v;				}			}			else {				_conveyorBeltSpeed = v;			}		}				public function get conveyorBeltSpeed():Number {			if(b2fixtures && b2fixtures.length > 0) {				return b2fixtures[0].m_conveyorBeltSpeed;			}			else {				return _conveyorBeltSpeed;			}		}				public var _conveyorBeltSpeed:Number = 0;								/// This will force the BodyShape to use the ground as a body and act as a shape.		[Inspectable(defaultValue=false)]		public var isGround:Boolean = false;						/// Apply gravity?		[Inspectable(defaultValue=true)]		public var applyGravity:Boolean = true;				/// Create a mouse joint to let the user move bodies around?		[Inspectable(defaultValue=true)]		public var allowDragging:Boolean = true;				/// If the body is animated within flash via tweens or other means, setting this to true will create mouse joints		/// to keep the b2body in sync with the display object, rather than the other way around.		[Inspectable(defaultValue=false)]		public var tweened:Boolean = false;		public var world:World = null;		public var selfBody:Boolean = false; /// Is this BodyShape acting as b2Body?		public var body:BodyShape = null;		public var b2body:b2Body = null;		public var b2fixtures:Vector.<b2Fixture> = null; /// An array of b2Fixtures - Get the shape by fixture.m_shape.		public var matrix:Matrix = null; /// A transform matrix that helps with Box2d -> BodyShape coordinate translation.		public var gravity:V2; /// The last gravity vector applied to this body (only set when acting as a body).		public var dragJoint:Joint;				public var bufferedShapes:Array = [];				public function shape(shapeFunc:Function, ...args):void {			if(world) {				shapeFunc.apply(this, args);			}			else {				bufferedShapes.push([shapeFunc, args]);			}		}				public function createBufferedShapes():void {			for(var i:int = 0; i < bufferedShapes.length; ++i) {				bufferedShapes[i][0].apply(this, bufferedShapes[i][1]);			}			bufferedShapes = [];		}				/**		 * Override this to define the shapes that should be created. Use the helper methods below to		 * make sure the shapes have the correct transform and properties.		 *		 * box();		 * box(5, 10);		 * circle(20);		 * polygon([[0,0],[10,0],[0,10]]);		 * etc.		 */		public function shapes():void {		}				/**		 * Define a box. If you don't pass a halfWidth or halfHeight, it'll try to calculate them from the BodyShape's visible width & height.		 * angle is in degrees. The BodyShape may be skewed, in which case the physical shape defined will not be a rectangle or a box.		 */		public function box(w:Number = 0, h:Number = 0, pos:V2 = null, angle:Number = 0):b2Fixture {			pos ||= new V2();			if(w == 0 || h == 0) {				var b:Rectangle = Util.bounds(this);				if(w == 0) w = b.width;				if(h == 0) h = b.height;			}			var halfWidth = w / 2;			var halfHeight = h / 2;			var vertices:Vector.<V2> = Vector.<V2>([				new V2(-halfWidth, -halfHeight), 				new V2(halfWidth, -halfHeight), 				new V2(halfWidth, halfHeight), 				new V2(-halfWidth, halfHeight)			]);			orientVertices(vertices, pos, angle);			return polygon(vertices);		}				/**		 * Define a circle. If you don't pass a radius, it'll guess one from the width. Note: Skew transforms wont work, neither will non-uniform XY		 * scaling (an oval shape).		 */		public function circle(radius:Number = 0, pos:V2 = null):b2Fixture {			pos ||= new V2();			if(radius == 0) {				var b:Rectangle = Util.bounds(this);				radius = b.width / 2;			}			var v1:V2 = pos.clone();			var v:Vector.<V2> = Vector.<V2>([v1, new V2(v1.x + radius, v1.y)]);			transformVertices(v);			b2Def.circle.m_radius = v[1].x - v[0].x;			b2Def.circle.m_p.x = v[0].x;			b2Def.circle.m_p.y = v[0].y;			initFixtureDef();			b2Def.fixture.shape = b2Def.circle;			return createFixture();		}				/**		 * Define a stretchable circle. 		 */		public function oval(width:Number = 0, height:Number = 0, pos:V2 = null, sides:uint = 0, detail:Number = 4, angle:Number = 0):Array {			pos ||= new V2();			if(width == 0) {				var b:Rectangle = Util.bounds(this);				width = b.width;				height = b.height;			}			var w2 = width / 2;			var h2 = height / 2;			/// TO DO: better way to detect circle shape?			var p1:Point = Util.localizePoint(world, this, new Point(w2, 0));			var p2:Point = Util.localizePoint(world, this, new Point(0, h2));			var p3:Point = Util.localizePoint(world, this);			var d1:Number = Point.distance(p1, p3);			var d2:Number = Point.distance(p2, p3);			var a:Number = Math.abs(d1 - d2);			if(a < 2) { // Tolerance to snap to circle.				return [circle(w2, pos)];			}			if(sides == 0) {				var d = Point.distance(p1, p2);				sides = Math.round(d / world.scale * detail);			}			var polys:Array = [];			sides = Math.max(sides, 12);			for(var i:uint = 1; i < sides; i += 6) {				var v:Vector.<V2> = Vector.<V2>([new V2(w2, 0)]);				var j2:uint = Math.min(i + 6, sides - 1);				for(var j:uint = i; j <= j2; ++j) {					var rad:Number = j / sides * Math.PI * 2;					v.push(new V2(w2 * Math.cos(rad), h2 * Math.sin(rad)));				}				orientVertices(v, pos, angle);				polys.push(polygon(v));			}			return polys;		}				/**		 * Define a polygon with a variable number of sides.		 */		public function polyN(sides:uint = 5, radius:Number = 0, pos:V2 = null, angle:Number = 0):b2Fixture {			pos ||= new V2();			if(radius == 0) {				radius = Util.bounds(this).top;			}			var vertices:Vector.<V2> = new Vector.<V2>();			for(var i:uint = 0; i < sides; ++i) {				vertices.push(new V2(0, radius).rotate(i / sides * Math.PI * 2));			}			orientVertices(vertices, pos, angle);			return polygon(vertices);		}				/**		 *		 */		public function arc(degrees:Number = 360, sides:uint = 0, radius:Number = 0, pos:V2 = null, angle:Number = 0, detail:Number = 4):Array {			pos ||= new V2();			if(radius == 0) {				radius = Util.bounds(this).top;			}			if(sides == 0) {				/// Use the size of the arc to determine how many sides to use. The distance between <0,r> and <r,0> relative to the world				/// is a good indicator of how big the arc is.				var d = Point.distance(					Util.localizePoint(world, this, new Point(radius, 0)),					Util.localizePoint(world, this, new Point(0, radius))				);				sides = Math.round(d / world.scale * detail);			}			sides = Math.max(sides, 12); // Arbitrary minimum - but since <0,0> is part of every poly, forces them to be convex.			var rad:Number = Util.D2R * degrees;			var polys:Array = [];			for(var i:uint = 0; i < sides; i += 4) {				var v:Vector.<V2> = Vector.<V2>([new V2()]);				var j2:uint = Math.min(i + 4, sides);				for(var j:uint = i; j <= j2; ++j) {					v.push(new V2(0, radius).rotate(j / sides * rad));				}				orientVertices(v, pos, angle);				polys.push(polygon(v));			}			return polys;		}				/**		 *		 */		public function lineArc(degrees:Number = 360, sides:uint = 0, radius:Number = 0, pos:V2 = null, angle:Number = 0, detail:Number = 8):Array {			pos ||= new V2();			if(radius == 0) {				radius = Util.bounds(this).top;			}			if(sides == 0) {				/// Use the size of the arc to determine how many sides to use. The distance between <0,r> and <r,0> relative to the world				/// is a good indicator of how big the arc is.				var d = Point.distance(					Util.localizePoint(world, this, new Point(radius, 0)),					Util.localizePoint(world, this, new Point(0, radius))				);				sides = Math.round(d / world.scale * detail);			}			var rad:Number = Util.D2R * degrees;			var polys:Array = [];			var v:Vector.<V2> = Vector.<V2>([new V2(0, radius)]);			for(var i:uint = 0; i < sides; ++i) {				v[1] = new V2(0, radius).rotate((i + 1) / sides * rad);				orientVertices(v, pos, angle);				polys.push(line(v[0], v[1]));				v[0].x = v[1].x;				v[0].y = v[1].y;			}			return polys;		}				/**		 * A right triangle constructed in the same way as the "box" function but with the upper right vertex deleted.		 */		public function triangle(w:Number = 0, h:Number = 0, pos:V2 = null, angle:Number = 0):b2Fixture {			 pos ||= new V2();			 if(w == 0 || h == 0) {					var b:Rectangle = Util.bounds(this);					if(w == 0) w = b.width;					if(h == 0) h = b.height;			 }			 var halfWidth = w / 2;			 var halfHeight = h / 2;			 var vertices:Vector.<V2> = Vector.<V2>([					new V2(-halfWidth, -halfHeight),					//new V2(halfWidth, -halfHeight),					new V2(halfWidth, halfHeight),					new V2(-halfWidth, halfHeight)			 ]);			 orientVertices(vertices, pos, angle);			 return polygon(vertices);		}						/**		 *		 */		public function line(v1:V2 = null, v2:V2 = null):b2Fixture {			if(!(v1 && v2)) {				var b:Rectangle = Util.bounds(this);				v1 ||= new V2(0, b.top);				v2 ||= new V2(0, b.bottom);			}			return polygon(Vector.<V2>([v1, v2]));		}								/**		 * Define a polygon. Pass in an array of vertices in [[x, y], [x, y], ...] format		 */		public function poly(vertices:Array):b2Fixture {			var v:Vector.<V2> = new Vector.<V2>();			for(var i:int = 0; i < vertices.length; ++i) {				v.push(new V2(vertices[i][0], vertices[i][1]));			}			return polygon(v);		}				/**		 * Takes an array of polygon points - each is sent to the "poly" function.		 */		public function polys(vertices:Array):Array {			var a:Array = [];			for(var i:int = 0; i < vertices.length; ++i) {				a.push(poly(vertices[i]));			}			return a;		}				/**		 *		 */		public function decomposedPoly(vertices:Vector.<Number>):Array {			for(var i:int = 0; i < vertices.length; ++i) {				vertices[i] /= world.scale;			}			var s:Vector.<b2PolygonShape> = b2PolygonShape.Decompose(vertices);			initFixtureDef();			var f:Array = [];			for(i = 0; i < s.length; ++i) {				b2Def.fixture.shape = s[i];				f.push(createFixture());				s[i].destroy();			}			return f;		}				/**		 * Like poly(), but takes a V2 vector.		 */		public function polygon(vertices:Vector.<V2>):b2Fixture {			transformVertices(vertices);			/// If the bodyshape has been flipped on its y or x axis, then vertices are in the wrong direction.			b2PolygonShape.EnsureCorrectVertexDirection(vertices);			b2Def.polygon.Set(vertices);			initFixtureDef();			b2Def.fixture.shape = b2Def.polygon;			return createFixture();		}				/**		 * Initialize fixture def properties.		 */		public function initFixtureDef():void {			if(b2Def.fixture.userData == this) {				return; /// Fixture def is already in sync.			}			b2Def.fixture.friction = _friction;			b2Def.fixture.restitution = _restitution;			b2Def.fixture.density = _density;			b2Def.fixture.filter.categoryBits = _categoryBits;			b2Def.fixture.filter.maskBits = _maskBits;			b2Def.fixture.filter.groupIndex = _groupIndex;			b2Def.fixture.isSensor = _isSensor;			b2Def.fixture.userData = this;		}				/**		 * Add the shape to the b2fixtures array and sets common shape properties.		 */		public function createFixture():b2Fixture {			var fix:b2Fixture = new b2Fixture(b2body, b2Def.fixture, this);			b2fixtures.push(fix);			fix.m_reportBeginContact = _reportBeginContact;			fix.m_reportEndContact = _reportEndContact;			fix.m_reportPreSolve = _reportPreSolve;			fix.m_reportPostSolve = _reportPostSolve;			fix.m_conveyorBeltSpeed = _conveyorBeltSpeed;			return fix;		}				/**		 * Takes a polygon (list of vertices) and rotates, repositions them.		 */		public function orientVertices(vertices:Vector.<V2>, pos:V2 = null, angle:Number = 0):void {			pos ||= new V2();			if(angle != 0 || pos.x != 0 || pos.y != 0) {				for(var i:uint = 0; i < vertices.length; ++i) {					vertices[i].rotate(Util.D2R * angle).add(pos);				}			}		}				/**		 * Takes an array of vertices ([[x,y],[x,y]]) and transforms them based on their MovieClip transformation.		 */		public function transformVertices(vertices:Vector.<V2>):void {			for(var i:int = 0; i < vertices.length; ++i) {				vertices[i] = transformVertex(vertices[i]);			}		}				/**		 * Will take a flash X,Y within this object and return a new X,Y reflecting where that		 * X, Y is in Box2d dimentions.		 */		public function transformVertex(xy:V2):V2 {			var p:Point = matrix.transformPoint(xy.toP());			return new V2(p.x / world.scale, p.y / world.scale);		}				/**		 * Determine the role this BodyShape should play and either create a body (possibly with shapes) or shapes (in another body).		 */		public override function create():void {			world = Util.findAncestorOfClass(this, World) as World;			if(!world || world.disabled) {				return;			}			world.ensureCreated();			if(isGround) {				world.doOutsideTimeStep(createShapes);			}			else {				body = Util.findAncestorOfClass(this, BodyShape) as BodyShape;				if(body) {					if(!body.disabled) {						body.ensureCreated();						if(body.world == world) { /// Quickly thrown in to allow worlds in worlds...							body = body.body;							world.doOutsideTimeStep(createShapes);						}						else {							world.doOutsideTimeStep(createBody);						}					}				}				else if(world) {					world.doOutsideTimeStep(createBody);				}			}			super.create();		}				/**		 * Destroy either as a body or a shape. Doesn't do the destroying if the body or world ancestor was destroyed,		 * because that implicitly destroys the body / shapes.		 */		public override function destroy():void {			if(world && world.created && !world.disabled && world.parent) {				if(selfBody) {					world.doOutsideTimeStep(destroyBody);				}				else if(body && !body.disabled && (body.created || body.isGround)) {					world.doOutsideTimeStep(destroyShapes);				}			}			else {				b2fixtures = null;				b2body = null;			}		}				/**		 * BodyShape is assuming the role of a b2Body. Create the body and record the transformation matrix so we know		 * how to translate box2d transforms into Flash transforms. Also allow the body to define its own shapes within		 * its self.		 */		public function createBody():void {			selfBody = true;			body = this;			matrix = Util.localizeMatrix(world, this);			b2Def.body.position.x = matrix.tx / world.scale;			b2Def.body.position.y = matrix.ty / world.scale;			b2Def.body.angle = Math.atan2(matrix.b, matrix.a); //MatrixTransformer.getRotationRadians(matrix);			b2Def.body.linearVelocity.x = _linearVelocity.x;			b2Def.body.linearVelocity.y = _linearVelocity.y;			b2Def.body.angularVelocity = _angularVelocity;			b2Def.body.linearDamping = _linearDamping;			b2Def.body.angularDamping = _angularDamping;			b2Def.body.allowSleep = _autoSleep;			b2Def.body.awake = _awake;			b2Def.body.fixedRotation = _fixedRotation;			b2Def.body.bullet = _bullet;			b2Def.body.type = {Static: b2Body.b2_staticBody, Kinematic: b2Body.b2_kinematicBody, Dynamic: b2Body.b2_dynamicBody}[_type];			b2Def.body.active = _active;			b2Def.body.inertiaScale = _inertiaScale;			b2Def.body.userData = this;			b2body = new b2Body(world.b2world, b2Def.body);			matrix.tx = 0;			matrix.ty = 0;						/// This can probably be simplified. Taken from flash's MatrixTransormer class. Tries to set the matrix rotation to zero while preserving			/// scale, skew, etc.			var skX:Number = Math.atan2(-matrix.c, matrix.d) - Math.atan2(matrix.b, matrix.a);			var scY:Number = Math.sqrt(matrix.c * matrix.c + matrix.d * matrix.d);			matrix.c = -scY * Math.sin(skX);			matrix.d =  scY * Math.cos(skX);			matrix.a = Math.sqrt(matrix.a * matrix.a + matrix.b * matrix.b);			matrix.b = 0;			b2fixtures = new Vector.<b2Fixture>();			createBufferedShapes();			shapes();			if(!b2body.IsStatic()) {				setUpdateMethod(tweened);			}		}				/**		 *		 */		public function setUpdateMethod(tween:Boolean = false):void {			if(tween) {				listenWhileVisible(world, StepEvent.STEP, updateTween, false, 2);				lastP = Util.localizePoint(world, this);				lastR = Util.localizeRotation(world, this);				stopListening(world, StepEvent.STEP, updateBodyMatrixSimple);				stopListening(world, StepEvent.STEP, updateBodyMatrix);			}			else { 				if(parent == world) {					listenWhileVisible(world, StepEvent.STEP, updateBodyMatrixSimple, false, -10);									}				else {					listenWhileVisible(world, StepEvent.STEP, updateBodyMatrix, false, -10);				}				stopListening(world, StepEvent.STEP, updateTween);			}		}				/**		 * Translate the new tweened position & rotation into velocities for Box2d.		 */		public var lastP:Point;		public var lastR:Number;		public function updateTween(e:Event):void {			var p2:Point = Util.localizePoint(world, this);			var r2:Number = Util.findBetterAngleTarget(lastR, Util.localizeRotation(world, this));			/// I'm really not sure why 0.05 / 20 are the magic numbers here, but they work perfect.			var lv:V2 = new V2(p2.x - lastP.x, p2.y - lastP.y).divideN(world.scale * 0.05);			b2body.SetLinearVelocity(lv);			var av:Number = (r2 - lastR) * Util.D2R * 20;			b2body.SetAngularVelocity(av);			lastP = p2;			lastR = r2;		}				/**		 * BodyShape is acting as a shape on another body. Create shapes on that body.		 */		public function createShapes():void {			if(isGround) {				matrix = Util.localizeMatrix(world, this);				body = this;				b2body = world.b2world.m_groundBody;			}			else {				body.ensureCreated();				b2body = body.b2body;				matrix = Util.localizeMatrix(body, this);				matrix.concat(body.matrix);			}			selfBody = false;			b2fixtures = new Vector.<b2Fixture>();			shapes();			createBufferedShapes();		}				/**		 * Destroy a BodyShape acting as a Body. Any shapes it creates for itself are automatically destroyed in Box2d.		 */		public function destroyBody():void {			b2body.destroy();			b2body = null;			b2fixtures = null;		}				/**		 * Destroy a BodyShape acting as a shape collection on another BodyShape.		 */		public function destroyShapes():void { 			for(var i:int = 0; i < b2fixtures.length; i++) {				b2fixtures[i].destroy();			}			b2body = null;			b2fixtures = null;		}				/**		 * Read the current position and rotation from Box2d and reposition the visible BodyShape.		 */		public function updateBodyMatrix(e:Event):void {			var m:Matrix = matrix.clone();			m.rotate(b2body.m_sweep.a % Util.PI2);			m.translate(b2body.m_xf.position.x * world.scale, b2body.m_xf.position.y * world.scale);			if(parent != world) {				/// This might introduce some overhead, but is necessary if the body is not a direct descendant of the world. There				/// may be transformations between the world and the body we are not aware of and they might change. It wouldn't be necessary if the objects				/// between the world and the body had a transform that never changed... can't be sure of that though. Maybe have a flag				/// the user can set to tell the engine these transforms never change and to skip this step?				var fix:Matrix = Util.localizeMatrix(world, parent);				fix.invert();				m.concat(fix);			}			transform.matrix = m;		}				/**		 * A simpler version of "updateBodyMatrix" for when the body is a direct descendent of the world. May have performance gains.		 */		public function updateBodyMatrixSimple(e:Event):void {			rotation = b2body.m_sweep.a * Util.R2D % 360;			x = b2body.m_xf.position.x * world.scale;			y = b2body.m_xf.position.y * world.scale;		}						/**		 * Start dragging via a mouse joint.		 */		public override function handleDragStart(e:Event):void {			if(b2body.IsDynamic() && world.allowDragging && allowDragging) {				if(e) {					e.stopImmediatePropagation();				}				b2body.SetAwake(true);				super.handleDragStart(e);				createDragJoint();				dragJoint.type = "Mouse";				var p:Point = Input.mousePositionIn(world);				dragJoint.x = p.x;				dragJoint.y = p.y;				dragJoint.bodyShape1 = this;				world.addChild(dragJoint);			}		}				/**		 * This could be overridden to further customize the mouse joint.		 */		public function createDragJoint() {			dragJoint = new dragJointClass() as Joint;			dragJoint.maxForce = dragJointStrength + (b2body.m_mass * dragJointMassFactor);			dragJoint.frequencyHz = 999999;			dragJoint.dampingRatio = 0;			dragJoint.collideConnected = true;		}				/**		 * Move the target of the mouse joint.		 */		public override function handleDragStep(e:Event):void {			var p:Point = Input.mousePositionIn(world);			(dragJoint.b2joint as b2MouseJoint).SetTarget(new V2(p.x / world.scale, p.y / world.scale));		}				/**		 * Destroy the mouse joint.		 */		public override function handleDragStop(e:Event):void {			super.handleDragStop(e);			Util.remove(dragJoint);		}	}}