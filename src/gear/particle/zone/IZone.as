package gear.particle.zone {
	import gear.particle.core.Particle;

	import flash.geom.Point;

	/**
	 * @author Administrator
	 */
	public interface IZone {
		function contains(x : Number, y : Number) : Boolean;

		function getLocation() : Point;

		function getArea() : Number;

		function collideParticle(particle : Particle, bounce : Number = 1) : Boolean;
	}
}
