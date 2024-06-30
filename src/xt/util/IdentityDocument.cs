using System;
using System.Runtime.Serialization;

namespace Lime.Protocol
{
    /// <summary>
    /// Represents an identity document.
    /// </summary>
    [DataContract(Namespace = "http://limeprotocol.org/2014")]
    public sealed class IdentityDocument : Document
    {
        public const string MIME_TYPE = "application/vnd.lime.identity";
        public static readonly MediaType MediaType = MediaType.Parse(MIME_TYPE);

        public IdentityDocument() 
            : this(null)
        {
        }

        public IdentityDocument(Identity value) : base(MediaType)
        {
            Value = value;
        }

        /// <summary>
        /// The value of the document
        /// </summary>
        public Identity Value { get; set; }

        public override string ToString() => Value.ToString();

        /// <summary>
        /// Parses the string to a 
        /// IdentityDocument instance.
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static IdentityDocument Parse(string value) => new IdentityDocument(value);
    }
}
