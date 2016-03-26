package tink.ufront.web.middleware;

import haxe.io.BytesOutput;
import ufront.app.UFMiddleware;
import ufront.web.context.HttpContext;
import tink.io.Sink;
import tink.io.Pipe;
import tink.io.Worker;

using tink.CoreApi;

class BodyMiddleware implements UFRequestMiddleware {
	
	public function new() {
		
	}
	
	public function requestIn( ctx:HttpContext ):Surprise<Noise,Error> {
		
		var request = cast(ctx.request, tink.ufront.web.context.HttpRequest);
		
		var buf = new BytesOutput();
		
		// TODO: check Content-Type, don't try to parse multipart forms
		
		return request.request.body
			.pipeTo(Sink.ofOutput('HTTP request body buffer', buf, Worker.EAGER)) >>
				function(x:PipeResult<Error, Error>) return switch x {
					case AllWritten:
						request.setPostString(buf.getBytes().toString());
						Success(Noise);
					default:
						Success(Noise); // TODO: handle the error?
				}
	}
}