﻿package {		import Box2DAS.*;	import Box2DAS.Collision.*;	import Box2DAS.Collision.Shapes.*;	import Box2DAS.Common.*;	import Box2DAS.Dynamics.*;	import Box2DAS.Dynamics.Contacts.*;	import Box2DAS.Dynamics.Joints.*;	import misc.*;		public class Wave extends Test {				public function Wave() {			super();			Main.txt.text = "Wave";						var n:Number = 720 / 100 / scale;			var b:b2Body = m_groundBody;			var new_b:b2Body;						b2Def.body.position.y = 200 / scale;			b2Def.body.type = b2Body.b2_dynamicBody;			b2Def.polygon.SetAsBox(n / 2, 0.01);			b2Def.fixture.shape = b2Def.polygon;			b2Def.fixture.density = 0;						for(var i:int = 0; i < 100; ++i) {				b2Def.body.position.x = (i * n) + (.5 * n);				new_b = CreateBody(b2Def.body);				new_b.CreateFixture(b2Def.fixture);				b2Def.revoluteJoint.Initialize(b, new_b, new V2(i * n, 200 / scale));				CreateJoint(b2Def.revoluteJoint);				b = new_b;			}			b2Def.revoluteJoint.Initialize(b, m_groundBody, new V2(i * n, 200 / scale));			CreateJoint(b2Def.revoluteJoint);						b2Def.body.position.x = 300 / scale;			b2Def.body.position.y = 100 / scale;						b = CreateBody(b2Def.body);			b2Def.fixture.shape = b2Def.circle;			b2Def.circle.m_radius = 50 / scale;			b.CreateFixture(b2Def.fixture);		}	}}