package ufront.external.mvc;
import ufront.web.mvc.DefaultDependencyResolver;
import ufront.web.mvc.IDependencyResolver;
import thx.util.TypeServiceLocator;
import thx.error.NullArgument;

/**
 * ...
 * @author Franco Ponticelli
 */

class ThxDependencyResolver implements IDependencyResolver
{
	public var locator(default, null) : TypeServiceLocator;
	public var defaultResolver : IDependencyResolver;
	
	public function new(locator : TypeServiceLocator)
	{
		NullArgument.throwIfNull(locator, "locator");
		this.locator = locator;
		this.defaultResolver = new DefaultDependencyResolver();
	}
	
	public function getService<T>(serviceType:Class<T>):T 
	{
		var o = locator.get(serviceType);
		if (null == o)
			return defaultResolver.getService(serviceType);
		else
			return o;
	}
}